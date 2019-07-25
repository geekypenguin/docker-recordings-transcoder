# djaydev/autoconvert

FROM lsiobase/ubuntu:bionic
RUN apt update && \
apt install --no-install-recommends python-pip python-setuptools mediainfo libfreetype6 libc6 libutf8proc2 libtesseract4 libpng16-16 liblept5 pkgconf libva2 libva-drm2 expat libgomp1 -y && \
# cleanup
apt-get autoremove -y && \
apt-get clean && \
rm -rf \
  /tmp/* \
  /var/lib/apt/lists/*

RUN pip install watchdog --install-option="--install-scripts=/usr/bin"

# Copy ccextractor
COPY --from=djaydev/ccextractor:latest /usr/local/bin /usr/local/bin
# Copy ffmpeg
COPY --from=jellyfin/ffmpeg:latest /usr/local /usr/local/
# Copy the start script.
COPY startapp.sh /etc/services.d/autoconvert/run
COPY /scripts /scripts

ENV ENCODER=nvidia \
    SUBTITLES=1 \
    DELETE_TS=0