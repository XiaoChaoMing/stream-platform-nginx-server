#!/bin/sh

RECORDINGS_DIR="/var/recordings"
LOG_FILE="/var/log/flv-conversion.log"

echo "$(date): Starting FLV to MP4 conversion service" | tee -a $LOG_FILE

# Create a function to convert a file
convert_file() {
    flv_file="$1"
    mp4_file=$(echo "$flv_file" | sed 's/\.flv$/.mp4/')
    
    echo "$(date): Converting $flv_file to $mp4_file" | tee -a $LOG_FILE
    
    # Convert the file using ffmpeg
    ffmpeg -i "$flv_file" -codec copy "$mp4_file" 2>> $LOG_FILE
    
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "$(date): Conversion successful. Removing original .flv file." | tee -a $LOG_FILE
        rm "$flv_file"
    else
        echo "$(date): Error converting $flv_file" | tee -a $LOG_FILE
    fi
}

# Process any existing .flv files
echo "$(date): Processing existing .flv files" | tee -a $LOG_FILE
find $RECORDINGS_DIR -name "*.flv" | while read flv_file; do
    convert_file "$flv_file"
done

# Watch for new .flv files using inotifywait
echo "$(date): Watching for new .flv files" | tee -a $LOG_FILE
while true; do
    inotifywait -e close_write,moved_to --format "%w%f" -r $RECORDINGS_DIR | while read file; do
        case "$file" in
            *.flv)
                # Wait a moment to ensure the file is completely written
                sleep 2
                convert_file "$file"
                ;;
        esac
    done
done 