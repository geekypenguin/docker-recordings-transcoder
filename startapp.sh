#!/usr/bin/with-contenv bash
exec watchmedo shell-command \
    --patterns="*.ts" \
    --recursive \
    --command='/bin/bash /config/postProcessScript.sh ${watch_src_path}' \
    /watch
