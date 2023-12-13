#!/bin/bash

# Specify the output device (external hard drive mount point)
output_device="/mnt/backup"
log_file="~/utils/backup/backup.log"

# Expand the tilde to home directory
log_file=$(eval echo "$log_file")

# Check if the log file exists, create it if not
if [ ! -f "$log_file" ]; then
    touch "$log_file"
fi

# Function to log messages
log_message() {
	echo "$(date '+%d/%m/%Y %H:%M:%S') - $1"
	echo "$(date '+%d/%m/%Y %H:%M:%S') - $1" >> "$log_file"
}

# Start of backup log
log_message "Backup started."

# Check for dry-run option
dry_run=0
if [ "$1" = "--dry-run" ]; then
    dry_run=1
    log_message "Performing a dry-run..."
fi

# Function to display and log statistics
display_stats() {
    local dir=$1
    local size=$(du -sh "$dir" | cut -f1)

    if [[ -d "$dir" ]]; then
        local total_files=$(find "$dir" -type f | wc -l)
        log_message "Directory: $dir, Size: $size, Total files: $total_files"
    else
        log_message "File: $dir, Size: $size"
    fi
}

# Backup operation
start_time=$(date +%s)

total_size=0
while IFS= read -r dir
do
    if [[ -e "$dir" ]]; then
        display_stats "$dir"

        if [ $dry_run -eq 0 ]; then
            echo "Backing up $dir..."
            rsync -av --progress "$dir" "$output_device" | tee -a "$log_file"
        fi
    else
        log_message "Directory or file $dir not found."
    fi
done < ~/utils/backup/dirs.list

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
log_message "Backup completed. Elapsed time: $(date -ud @$elapsed_time +'%H:%M:%S')"

# End of backup log
log_message "Backup finished."
