#!/usr/bin/with-contenv bash
if [ ${ENCODER} = "nvidia" ] ; then
export ENCODER_SCRIPT=nvidia 
fi
if [ ${ENCODER} = "intel" ] ; then
export ENCODER_SCRIPT=intel 
fi
if [ ${ENCODER} = "software" ] ; then
export ENCODER_SCRIPT=software
fi
if [ ${SUBTITLES} = "0" ] ; then
export ENCODER_SCRIPT_END=.sh 
fi
if [ ${SUBTITLES} = "1" ] ; then
export ENCODER_SCRIPT_END=-subtitles.sh
fi
if [ ${DELETE_TS} = "1" ] ; then
 echo "rm \"\$1\"" | tee /scripts/*.sh > /dev/null
fi
chmod +x /scripts/*
