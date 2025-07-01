# DabDockerr

A Docker-based browser wrapper for accessing music download sites with automatic file management and ad-blocking capabilities.

## Features

- 🌐 Web-based browser interface accessible via port 5656
- 🚫 Built-in uBlock Origin ad-blocking (invisible to user)
- 📁 Automatic file management:
  - Monitors downloads folder for zip files and audio files
  - Extracts zip files automatically
  - Organizes files into specified music directory
- 🐳 Easy Docker deployment with single command
- 🔒 Secure containerized environment

## Quick Start

1. Create a new directory for the application
2. Download the `docker-compose.yml` file to this directory
3. Open terminal in the directory
4. Run: `docker-compose up -d`
5. Access the web interface at `http://your-ip:5656`

## Configuration

### Environment Variables

You can customize the music folder location by setting the `MUSIC_FOLDER` environment variable:

```bash
MUSIC_FOLDER=/path/to/your/music docker-compose up -d
```

Or modify the docker-compose.yml file to set a permanent path.

### Directory Structure

```
your-app-folder/
├── docker-compose.yml
├── config/           # Browser configuration and user data
├── downloads/        # Temporary download location (auto-processed)
└── Music/           # Final music library location (customizable)
```

## How It Works

1. **Browser Wrapper**: Provides a Chromium browser in a container with uBlock Origin pre-loaded
2. **File Monitor**: Watches the downloads directory for new files
3. **Auto-Processing**: 
   - ZIP files are extracted and moved to music folder
   - Individual audio files are moved directly to music folder
4. **Ad-Blocking**: uBlock Origin runs invisibly to block ads and improve performance

## Supported File Types

- **Archives**: ZIP files (auto-extracted)
- **Audio**: MP3, FLAC, WAV, M4A, OGG, AAC

## Access

- Web Interface: `http://localhost:5656` (or your server IP + port 5656)
- The interface will automatically load the target music site
- All downloads will be automatically processed and organized

## Security Notes

- The container runs with necessary permissions for Chrome operation
- uBlock Origin is embedded and not visible in the browser interface
- All file operations are contained within the Docker environment

## Troubleshooting

### Container won't start
- Ensure port 5656 is available
- Check Docker daemon is running
- Verify sufficient disk space

### Files not processing
- Check that the downloads and music folders are properly mounted
- Verify write permissions on mounted volumes
- Check container logs: `docker-compose logs dab-wrapper`

### Browser issues
- Try refreshing the web interface
- Restart the container: `docker-compose restart`
- Check container resources (may need more RAM/CPU)

## Building from Source

If you want to build the image locally instead of using the pre-built one:

1. Clone this repository
2. Run: `docker build -t elliotonthenet18/dab-dockerr .`
3. Update docker-compose.yml to use your local image

## Contributing

Feel free to submit issues and pull requests to improve the application.

## License

This project is provided as-is for educational purposes. Please respect the terms of service of any websites you access and local copyright laws.