# Stream Server with Docker

This project provides a streaming server with both HLS and RTMP support using Docker, along with a web player interface.

## Features

- RTMP streaming server (port 1936)
- HLS streaming (ports 8081 and 8082)
- Web-based player interface for both HLS and RTMP streams
- CORS support for cross-domain playback

## Quick Start

1. Build and start the Docker container:

```bash
docker-compose up -d
```

2. Access the web player:

   - Open your browser and navigate to: `http://localhost:8081` or `http://your-server-ip:8081`

3. Stream to the server:

   - Use OBS Studio or similar software
   - Set the streaming URL to: `rtmp://localhost:1936/live` or `rtmp://your-server-ip:1936/live`
   - Set the stream key to: `test` (or your preferred key)

4. View the stream:
   - The HLS stream will be available at: `http://localhost:8082/hls/test.m3u8`
   - The RTMP stream will be available at: `rtmp://localhost:1936/live/test`
   - Both can be played through the web interface automatically

## Port Configuration

- Port 1936: RTMP streaming (mapped to internal port 1935)
- Port 8081: HTTP (web player) (mapped to internal port 80)
- Port 8082: HLS streaming (mapped to internal port 8080)

## Volume Mapping

The Docker setup maps the `./hls` directory in your project to `/tmp/hls` in the container for persistent HLS segments.

## Troubleshooting

- If you can't access the web player, ensure ports 8081 and 8082 are open and not being used by other services.
- If streaming fails, check that port 1936 is accessible.
- For CORS issues, the server is already configured to allow cross-origin requests.
# stream-server-rtmp
# stream-platform-nginx-server
