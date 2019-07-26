#!/usr/bin/with-contenv bash
if [ ${ENCODER} = "nvidia" ] ; then
echo ENCODER_SCRIPT=nvidia >> /scripts/setvariables.txt
fi
if [ ${ENCODER} = "intel" ] ; then
echo ENCODER_SCRIPT=intel >> /scripts/setvariables.txt
fi
if [ ${ENCODER} = "software" ] ; then
echo ENCODER_SCRIPT=software >> /scripts/setvariables.txt
fi
if [ ${SUBTITLES} = "0" ] ; then
echo ENCODER_SCRIPT_END=.sh >> /scripts/setvariables.txt
fi
if [ ${SUBTITLES} = "1" ] ; then
echo ENCODER_SCRIPT_END=-subtitles.sh >> /scripts/setvariables.txt
fi
if [ ${DELETE_TS} = "1" ] ; then
echo "rm \"\$1\"" | tee /scripts/*.sh > /dev/null
fi
chmod +x /scripts/*
