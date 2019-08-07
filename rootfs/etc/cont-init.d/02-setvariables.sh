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
if [ ${ENCODER} = "custom" ] ; then
sed -i "s/scripts\/ENCODEREND/config\/custom.sh/g" /etc/services.d/autovideoconverter/run
fi
if [ ${SUBTITLES} = "0" ] ; then
ENCODER_SCRIPT_END=.sh
else ENCODER_SCRIPT_END=-subtitles.sh
fi
if [ ${DELETE_TS} = "1" ] ; then
sed -i "s/#SEDIF/if/g" /scripts/$ENCODER_SCRIPT$ENCODER_SCRIPT_END
echo -e "rm \"\$1\"\nfi" | tee -a /scripts/*.sh > /dev/null
fi
chmod +x /scripts/*
sed -i "s/ENCODER/$ENCODER_SCRIPT/g" /etc/services.d/autovideoconverter/run
sed -i "s/END/$ENCODER_SCRIPT_END/g" /etc/services.d/autovideoconverter/run
sed -i "s/SEDUSER/$PUID/g" /etc/cont-init.d/10-autoconvertor.sh
sed -i "s/SEDGROUP/$PGID/g" /etc/cont-init.d/10-autoconvertor.sh
sed -i "s/SEDUMASK/$UMASK/g" /etc/cont-init.d/10-autoconvertor.sh
sed -i "s/SEDUSER/$PUID/g" /etc/services.d/autovideoconverter/run
sed -i "s/SEDGROUP/$PGID/g" /etc/services.d/autovideoconverter/run
sed -i "s/SEDUMASK/$UMASK/g" /etc/services.d/autovideoconverter/run
mkdir /output
