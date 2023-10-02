#!/bin/bash
# crontab -e
# m h  dom mon dow   command
# 0 5 * * *       /home/user/scripts/download-blocklist.sh

trap_handler() {
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        # echo "Exit code is zero"
        curl http://uptime-kuma.dockerbox.local/api/push/k3UrE9OU6p?status=up&msg=OK
    else
        # echo "Exit code is non-zero: $exit_code"
        # Add your curl command for non-zero exit code here
        # Example: curl -X GET http://example.com/error
        curl http://uptime-kuma.dockerbox.local/api/push/k3UrE9OU6p?status=up&msg=FAILURE
    fi
}

trap trap_handler EXIT

blocklist_url="http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=zip"
tmp_dir=$(mktemp -d)
blocklist_file="/home/user/docker/qbittorrent/blocklist.p2p"
blocklist_txt=""

wget "$blocklist_url" -O "$tmp_dir/blocklist.zip"
unzip "$tmp_dir/blocklist.zip" -d "$tmp_dir"
blocklist_txt=$(find "$tmp_dir" -type f -name "*.txt")

grep -v '^[[:space:]]*$' "$blocklist_txt"  > "$blocklist_file"
