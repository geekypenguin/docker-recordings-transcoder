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
sed -i "s/ENCODER/$ENCODER_SCRIPT/g" /scripts/sample.conf
sed -i "s/END/$ENCODER_SCRIPT_END/g" /scripts/sample.conf
sed -i "s/SEDUSER/$PUID/g" /scripts/runas.sh
sed -i "s/SEDGROUP/$PGID/g" /scripts/runas.sh
sed -i "s/SEDUMASK/$UMASK/g" /scripts/runas.sh
sed -i "s/SEDUSER/$PUID/g" /scripts/sample.conf
sed -i "s/SEDGROUP/$PGID/g" /scripts/sample.conf
sed -i "s/SEDUMASK/$UMASK/g" /scripts/sample.conf
