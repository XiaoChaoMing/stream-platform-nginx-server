# Automatic FLV to MP4 Conversion for RTMP Stream Recordings

This feature automatically converts recorded RTMP streams from FLV format to MP4 format.

## How It Works

1. When a stream ends, the RTMP server saves the recording as an FLV file in the `/var/recordings` directory (mapped to `./recordings` on your host).
2. A background script continuously monitors this directory for new FLV files.
3. When a new FLV file is detected, the script waits a few seconds to ensure the file is completely written, then converts it to MP4 format using FFmpeg.
4. After successful conversion, the original FLV file is removed, leaving only the MP4 file.

## Requirements

The Docker image includes all necessary dependencies:
- FFmpeg - for media conversion
- inotify-tools - for file monitoring

## Logs

Conversion logs are stored in `/var/log/flv-conversion.log` inside the container and mapped to `./logs/flv-conversion.log` on your host system.

## Troubleshooting

If conversions aren't happening:

1. Check the logs: `cat ./logs/flv-conversion.log`
2. Make sure the container has proper permissions to access the recordings directory
3. Verify that recordings are being saved correctly by checking `./recordings`

## Manual Conversion

If you need to convert an FLV file manually, you can use:

```bash
docker exec streaming-platform-server ffmpeg -i /var/recordings/your-file.flv -codec copy /var/recordings/your-file.mp4
```

## Customization

If you need to modify the conversion settings:

1. Edit `convert-recordings.sh`
2. Rebuild the Docker image: `docker-compose build`
3. Restart the container: `docker-compose down && docker-compose up -d` 