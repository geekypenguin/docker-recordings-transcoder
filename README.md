# docker-recordings-transcoder

Watches for .ts files in /watch and converts them to h265 .mp4 files automatically.  Use at your own risk.

Example run
```
docker run -d \
    --name=recordings-transcoder \
    -v /home/user/videos:/watch:rw \
    -v /docker/appdata/recordings-transcoder:/config:rw \
    -e ENCODER=software
    -e SUBTITLES=0
    -e DELETE_TS=0
    PUID=99
    PGID=100
    UMASK=000
    djaydev/recordings-transcoder
```
Where:
- `/docker/appdata/recordings-transcoder`: This is where the application stores its configuration, log and any files needing persistency.  Location to add a custom script for video conversion named custom.sh
- `/home/user/videos`: This location contains .ts files that need converting.  
- `ENCODER`: options are "intel" "nvidia" "software" "custom" explained below
- `SUBTITLES`: Include subtitles from the original .ts, 0 = no, 1 = yes
- `DELETE_TS`: After converting remove the original .ts recording file. 0 = no, 1 = yes
- `PUID`: ID of the user the application runs as.
- `PGID`: ID of the group the application runs as.
- `UMASK`: Mask that controls how file permissions are set for newly created files.

- ENCODER=intel  
This options runs a script when converting the .ts video to use ffmpeg with vaapi hardware acceleration enabled. It requires `--device /dev/dri:/dev/dri` to access the intel GPU in the docker container.
Only mpeg2 recordings are changed to h265.  Recordings that are h264 are only converted to .mp4 files.  The reason is because vaapi hw transcoding produced worst files sizes, or very bad video quality.  Don't agree? Then please use "software" or your own script, see the custom section below.

- ENCODER=nvidia  
This options runs a script when converting the .ts video to use ffmpeg with nvenc hardware acceleration enabled. It requires `--runtime=nvidia` and `-e NVIDIA_DRIVER_CAPABILITIES=all` to access the Nvidia GPU in the docker container.
Only mpeg2 recordings are changed to h265.  Recordings that are h264 are only converted to .mp4 files.  The reason is because nvenc hw transcoding produced worst files sizes, or very bad video quality.  Don't agree? Then please use "software" or your own script, see the custom section below.

- ENCODER=software  
This options runs a script when converting the .ts video to use ffmpeg with software encoding enabled. Very CPU intensive but results in the best file size to video quality ratio.
h264 and mpeg2 or any codec is converted to h265 .mp4 files.  Very good quality and file size.

- ENCODER=custom  
This options runs your script when converting the .ts video to use ffmpeg however you choose. With this option please include your script named "custom.sh" in the mapped /config folder.
Supports VAAPI hardware transcoding with the environmental variable ENCODER=intel.
