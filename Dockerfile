FROM alfg/nginx-rtmp:latest

# Install tools needed for FLV to MP4 conversion
RUN apk update && apk add --no-cache \
    ffmpeg \
    inotify-tools

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy conversion script
COPY convert-recordings.sh /usr/local/bin/convert-recordings.sh
RUN chmod +x /usr/local/bin/convert-recordings.sh

RUN mkdir -p /tmp/hls && chmod -R 777 /tmp/hls
RUN mkdir -p /var/log && touch /var/log/flv-conversion.log && chmod 666 /var/log/flv-conversion.log


# Test nginx configuration
RUN nginx -t

# Expose RTMP and HLS ports only
EXPOSE 1935 8080 

# Start nginx and the conversion script
CMD ["/bin/sh", "-c", "/usr/local/bin/convert-recordings.sh & nginx"]
