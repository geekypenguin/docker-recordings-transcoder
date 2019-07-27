# djaydev/autoconvert

FROM lsiobase/ubuntu:bionic
RUN apt update && \
apt install --no-install-recommends coreutils findutils expect tcl8.6 mediainfo libfreetype6 libc6 libutf8proc2 libtesseract4 libpng16-16 liblept5 pkgconf libva2 libva-drm2 expat libgomp1 -y && \
# cleanup
apt-get autoremove -y && \
apt-get clean && \
rm -rf \
  /tmp/* \
  /var/lib/apt/lists/*

# Copy ccextractor
COPY --from=djaydev/ccextractor:latest /usr/local/bin /usr/local/bin
# Copy ffmpeg
COPY --from=jellyfin/ffmpeg:latest /usr/local /usr/local/
# Copy the start scripts.
COPY rootfs/ /
COPY /scripts /scripts
RUN rm /etc/cont-init.d/10-adduser
ENV ENCODER=nvidia \
    SUBTITLES=1 \
    DELETE_TS=0 \
    PUID=99 \
    PGID=100 \
    UMASK=0000 \
    AUTOMATED_CONVERSION_FORMAT="mp4"
