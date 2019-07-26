#!/usr/bin/with-contenv bash
source /scripts/setvariables.txt
exec watchmedo shell-command \
    --patterns="*.ts" \
    --recursive \
    --command='/bin/bash /scripts/${ENCODER_SCRIPT}${ENCODER_SCRIPT_END} ${watch_src_path}' \
    /watch
