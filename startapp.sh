#!/usr/bin/with-contenv bash
if [ ${ENCODER} = "nvidia" ] ; then
ENCODER_SCRIPT=nvidia
fi
if [ ${ENCODER} = "intel" ] ; then
ENCODER_SCRIPT=intel
fi
if [ ${ENCODER} = "software" ] ; then
ENCODER_SCRIPT=software
fi
if [ ${SUBTITLES} = "0" ] ; then
ENCODER_SCRIPT_END=.sh
fi
if [ ${SUBTITLES} = "1" ] ; then
ENCODER_SCRIPT_END=-subtitles.sh
fi
if [ ${DELETE_TS} = "1" ] ; then
 echo "rm \"\$1\"" | tee /scripts/*.sh > /dev/null
fi
chmod +x /scripts/*
exec watchmedo shell-command \
    --patterns="*.ts" \
    --recursive \
    --command='/bin/bash /scripts/${ENCODER_SCRIPT}${ENCODER_SCRIPT_END} ${watch_src_path}' \
    /watch
