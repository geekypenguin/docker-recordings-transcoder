#!/usr/bin/with-contenv bash
exec watchmedo shell-command \
    --patterns="*.ts" \
    --recursive \
    --command='/scripts/ENCODEREND ${watch_src_path}' \
    /watch
