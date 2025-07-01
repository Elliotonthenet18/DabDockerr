#!/usr/bin/env python3

import os
import time
import shutil
import zipfile
import logging
from pathlib import Path
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class DownloadHandler(FileSystemEventHandler):
    def __init__(self, downloads_dir, music_dir):
        self.downloads_dir = Path(downloads_dir)
        self.music_dir = Path(music_dir)
        self.music_dir.mkdir(parents=True, exist_ok=True)
        
    def on_created(self, event):
        if event.is_directory:
            return
            
        file_path = Path(event.src_path)
        
        # Wait for file to be completely written
        time.sleep(2)
        
        try:
            if file_path.suffix.lower() == '.zip':
                self.handle_zip(file_path)
            elif file_path.suffix.lower() in ['.mp3', '.flac', '.wav', '.m4a', '.ogg', '.aac']:
                self.handle_audio(file_path)
        except Exception as e:
            logger.error(f"Error processing {file_path}: {e}")
    
    def handle_zip(self, zip_path):
        """Extract zip file and move contents to music directory"""
        logger.info(f"Processing zip file: {zip_path}")
        
        # Create extraction directory
        extract_dir = self.downloads_dir / zip_path.stem
        extract_dir.mkdir(exist_ok=True)
        
        try:
            with zipfile.ZipFile(zip_path, 'r') as zip_ref:
                zip_ref.extractall(extract_dir)
            
            # Move extracted folder to music directory
            dest_dir = self.music_dir / zip_path.stem
            if dest_dir.exists():
                shutil.rmtree(dest_dir)
            
            shutil.move(str(extract_dir), str(dest_dir))
            
            # Remove original zip file
            zip_path.unlink()
            
            logger.info(f"Extracted and moved {zip_path.stem} to {dest_dir}")
            
        except Exception as e:
            logger.error(f"Failed to extract {zip_path}: {e}")
            # Clean up on failure
            if extract_dir.exists():
                shutil.rmtree(extract_dir)
    
    def handle_audio(self, audio_path):
        """Move individual audio files to music directory"""
        logger.info(f"Processing audio file: {audio_path}")
        
        dest_path = self.music_dir / audio_path.name
        
        # Handle duplicate names
        counter = 1
        while dest_path.exists():
            name_parts = audio_path.stem, counter, audio_path.suffix
            dest_path = self.music_dir / f"{name_parts[0]}_{name_parts[1]}{name_parts[2]}"
            counter += 1
        
        try:
            shutil.move(str(audio_path), str(dest_path))
            logger.info(f"Moved {audio_path.name} to {dest_path}")
        except Exception as e:
            logger.error(f"Failed to move {audio_path}: {e}")

def main():
    # Install watchdog if not available
    try:
        from watchdog.observers import Observer
        from watchdog.events import FileSystemEventHandler
    except ImportError:
        logger.info("Installing watchdog...")
        os.system("pip3 install watchdog")
        from watchdog.observers import Observer
        from watchdog.events import FileSystemEventHandler
    
    downloads_dir = "/app/downloads"
    music_dir = "/app/music"
    
    # Create directories
    os.makedirs(downloads_dir, exist_ok=True)
    os.makedirs(music_dir, exist_ok=True)
    
    # Set up file system watcher
    event_handler = DownloadHandler(downloads_dir, music_dir)
    observer = Observer()
    observer.schedule(event_handler, downloads_dir, recursive=False)
    
    logger.info(f"Starting file monitor - watching {downloads_dir}")
    observer.start()
    
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
        logger.info("File monitor stopped")
    
    observer.join()

if __name__ == "__main__":
    main()