#!/usr/bin/with-contenv bash
exec watchmedo shell-command \
    --patterns="*.ts" \
    --recursive \
    --command='/bin/bash /scripts/ENCODEREND ${watch_src_path}' \
    /watch
