#!/bin/bash

#
# TRAP and UPKUMA NEEDED!
#
blocklist_url="http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=zip"
tmp_dir=$(mktemp -d)
blocklist_file="/home/user/docker/qbittorrent/blocklist.p2p"
blocklist_txt=""


wget "$blocklist_url" -O "$tmp_dir/blocklist.zip"

unzip "$tmp_dir/blocklist.zip" -d "$tmp_dir"

blocklist_txt=$(find "$tmp_dir" -type f -name "*.txt")


grep -v '^[[:space:]]*$' "$blocklist_txt"  > "$blocklist_file"

