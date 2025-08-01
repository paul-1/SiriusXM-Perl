# SiriusXM Perl Implementation

This document provides detailed information about the Perl implementation of the SiriusXM proxy server (`sxm.pl`).

## Overview

The `sxm.pl` script is a complete Perl port of the Python `sxm.py` script with additional enhancements:

- Multi-level debug logging (ERROR, WARN, INFO, DEBUG, TRACE)
- Enhanced error handling and exception management
- Proper signal handling for graceful shutdowns
- Web server persistence (doesn't exit when clients disconnect)
- Modern Perl best practices with strict and warnings
- Comprehensive documentation and usage examples

## Requirements

### Perl Modules Required
- `JSON::XS` - Fast JSON parsing (already available)
- `LWP::UserAgent` - HTTP client functionality
- `HTTP::Daemon` - HTTP server implementation  
- `HTTP::Cookies` - Cookie handling
- `URI` - URL manipulation
- `MIME::Base64` - Base64 encoding/decoding

### Installation
The required modules are installed automatically when setting up the environment:

```bash
sudo apt install libwww-perl libhttp-daemon-perl liburi-perl libmime-base64-perl
```

## Usage

### Basic Usage
```bash
# Start server on default port 9999
perl sxm.pl username password

# Start server on custom port
perl sxm.pl username password -p 8888

# List available channels
perl sxm.pl username password -l

# Use Canadian region
perl sxm.pl username password --canada

# Use environment variables for credentials
export SXM_USER="your_username"
export SXM_PASS="your_password"
perl sxm.pl dummy dummy -e
```

### Logging Levels
```bash
# Error messages only
perl sxm.pl username password --verbose ERROR

# Include warnings
perl sxm.pl username password --verbose WARN

# Standard info messages (default)
perl sxm.pl username password --verbose INFO

# Debug information
perl sxm.pl username password --verbose DEBUG

# Detailed trace information
perl sxm.pl username password --verbose TRACE
```

### Command Line Options
- `-l, --list` - List available channels and exit
- `-p, --port PORT` - Set server port (default: 9999)
- `-ca, --canada` - Use Canadian region instead of US
- `-e, --env` - Use SXM_USER and SXM_PASS environment variables
- `-v, --verbose LEVEL` - Set logging level (ERROR, WARN, INFO, DEBUG, TRACE)
- `-h, --help` - Show help message

## Features

### Authentication
- Secure login with username/password
- Session management with automatic re-authentication
- Support for both US and Canadian regions
- Environment variable support for credentials

### HTTP Server
- Serves HLS streams for SiriusXM channels
- Handles .m3u8 playlist files
- Serves .aac audio segments
- Provides encryption keys at /key/1 endpoint
- Persistent server that survives client disconnections
- Graceful handling of client timeouts

### Logging
- Five levels of logging detail
- Timestamped log entries
- Color-coded log levels for easy reading
- Comprehensive error reporting

### Error Handling
- Graceful handling of network errors
- Automatic session renewal when needed
- Proper cleanup on shutdown
- Signal handling for clean exits

## API Endpoints

When the server is running, it provides these endpoints:

- `http://localhost:PORT/CHANNEL.m3u8` - Playlist for channel
- `http://localhost:PORT/path/to/segment.aac` - Audio segments
- `http://localhost:PORT/key/1` - Encryption key
- `http://localhost:PORT/channel/CHANNEL` - Simplified channel information (JSON)
- `http://localhost:PORT/now-playing/CHANNEL_IDS` - Now-playing information (JSON)

Where:
- `PORT` is the configured port (default 9999)
- `CHANNEL` is the channel name, ID, or Sirius channel number
- `CHANNEL_IDS` is a single channel ID or comma-separated list of channel IDs

### Example URLs
```
http://localhost:9999/siriushits1.m3u8
http://localhost:9999/coffeehouse.m3u8
http://localhost:9999/2.m3u8
http://localhost:9999/channel/siriushits1
http://localhost:9999/channel/17
http://localhost:9999/channel/ESPN%20Radio
http://localhost:9999/now-playing/siriushits1
http://localhost:9999/now-playing/siriushits1,thepulse
http://localhost:9999/now-playing/2,5,17
```

### Channel Info Endpoint

The new `/channel/CHANNEL` endpoint returns simplified channel information as JSON:

```json
{
  "channelId": "siriushits1",
  "siriusChannelNumber": 2,
  "name": "SiriusXM Hits 1",
  "imageUrl": "https://example.com/image4.jpg"
}
```

**Fields returned:**
- `channelId` - The unique channel identifier
- `siriusChannelNumber` - The channel number (renamed from channelNumber)
- `name` - The channel display name
- `imageUrl` - URL of the 4th image from the images array (if available)

**Note:** The `imageUrl` field is only included if the channel has at least 4 images in its images array.

### Now-Playing Information Endpoint

The new `/now-playing/CHANNEL_IDS` endpoint returns current track information for the specified channels:

```json
{
  "channelId1": {
    "track": "Song Title",
    "artist": "Artist Name",
    "album": "Album Name",
    // ... additional track information
  },
  "channelId2": {
    "track": "Another Song",
    "artist": "Another Artist",
    "album": "Another Album",
    // ... additional track information
  }
}
```

**Usage examples:**
- Single channel: `/now-playing/siriushits1`
- Multiple channels: `/now-playing/siriushits1,thepulse,2`
- Channel numbers: `/now-playing/2,5,17`

**Features:**
- Accepts single channel ID or comma-separated list
- Handles channel names, IDs, and Sirius channel numbers
- Returns structured JSON with current track information
- Includes proper error handling for invalid channels

## Technical Implementation

### Class Structure
- `SiriusXM` - Main class handling authentication and API calls
- HTTP server implemented using `HTTP::Daemon`
- Modular design with clear separation of concerns

### Key Methods
- `login()` - Initial authentication
- `authenticate()` - Session authentication
- `get_channels()` - Fetch channel list
- `get_playlist()` - Get playlist for channel
- `get_segment()` - Fetch audio segments

### Security Features
- Secure cookie handling
- Proper session management
- Timeout protection for HTTP requests
- Safe signal handling

## Comparison with Python Version

### Maintained Features
- All original functionality preserved
- Same API endpoints and behavior
- Compatible command line interface
- Identical authentication flow

### Enhancements
- Multi-level logging system
- Better error handling and reporting
- Signal handling for graceful shutdowns
- Environment variable support
- Comprehensive documentation
- Modern Perl best practices

### Performance
- Similar performance to Python version
- Efficient HTTP handling with persistent connections
- Minimal memory footprint
- Fast JSON parsing with JSON::XS

## Troubleshooting

### Common Issues

1. **Authentication Failures**
   - Check username and password
   - Verify network connectivity
   - Try using TRACE logging for detailed info

2. **Module Not Found Errors**
   - Install required Perl modules
   - Check @INC paths with `perl -e 'print join("\n", @INC)'`

3. **Port Already in Use**
   - Use `-p` option to specify different port
   - Check for other running instances

4. **Permission Errors**
   - Ensure script is executable: `chmod +x sxm.pl`
   - Check file permissions

### Debug Information
Use `--verbose TRACE` to get detailed debug information including:
- HTTP request/response details
- Authentication token information
- Cookie values and session state
- Network communication logs

## License and Credits

This Perl implementation maintains compatibility with the original Python version while adding enhanced features and better error handling. It follows the same license terms as the original project.

Original Python implementation: https://github.com/andrew0/SiriusXM
Updated fork: https://github.com/mim-tmassey/SiriusXM