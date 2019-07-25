#!/usr/bin/with-contenv bash
if [ ${ENCODER} = "nvidia" ] ; then
echo ENCODER_SCRIPT=nvidia >> /scripts/variables.txt
fi
if [ ${ENCODER} = "intel" ] ; then
echo ENCODER_SCRIPT=intel >> /scripts/variables.txt
fi
if [ ${ENCODER} = "software" ] ; then
echo ENCODER_SCRIPT=software >> /scripts/variables.txt
fi
if [ ${SUBTITLES} = "0" ] ; then
echo ENCODER_SCRIPT_END=.sh >> /scripts/variables.txt
fi
if [ ${SUBTITLES} = "1" ] ; then
echo ENCODER_SCRIPT_END=-subtitles.sh >> /scripts/variables.txt
fi
if [ ${DELETE_TS} = "1" ] ; then
 echo "rm \"\$1\"" | tee /scripts/*.sh > /dev/null
fi
source /scripts/variables.txt
chmod +x /scripts/*
exec watchmedo shell-command \
    --patterns="*.ts" \
    --recursive \
    --command='/bin/bash /scripts/${ENCODER_SCRIPT}${ENCODER_SCRIPT_END} ${watch_src_path}' \
    /watch
