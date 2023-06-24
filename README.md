# VobSub2SRT-container

The [VobSub2SRT](https://github.com/ruediger/VobSub2SRT) command line tool is still a recommended program, but its last pre-release was in 2015 and build instructions are written for Ubuntu 12.04, so not the greatest circumstances. While there are various third party builds for some platforms, a clean setup in a purpose built container seems the most sensible to me.

## Run the container interactively

```bash
docker build --tag vobsub2srt:v1.0pre7 .
docker run -it --rm vobsub2srt:v1.0pre7 /bin/bash
```
