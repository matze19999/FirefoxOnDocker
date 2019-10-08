#Dockerfile: Firefox

# Geschrieben von
# Matthias Pröll <matthias.proell@staudigl-druck.de>
# Staudigl-Druck GmbH & Co. KG
# Letzte Anpassung: 2019/08/23

FROM jlesage/baseimage-gui:ubuntu-18.04

# Labels
LABEL vendor="Staudigl-Druck GmbH & Co. KG"
LABEL maintainer="Matthias Pröll (matthias.proell@staudigl-druck.de)"
LABEL release-date="2019-10-08"
LABEL org.label-schema.name="Mozilla Firefox"
LABEL org.label-schema.description="Docker container for Firefox"
LABEL org.label-schema.version="unknown"
LABEL org.label-schema.vcs-url="https://github.com/matze19999/firefoxOnDocker"
LABEL org.label-schema.schema-version="1.0"

RUN apt update && \
    apt install firefox wget curl rsync nano gnupg gnupg2 apt-utils libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly --no-install-recommends -y && \
    apt-get clean -y \
    apt-get autoremove -y \
    apt-get autoremove -y

RUN mkdir /home/firefox
RUN chmod 777 -R /home/firefox

RUN echo '#!/bin/bash\n\
export HOME=/home/firefox\n\
cp -r -f /firefox/* /home/firefox/\n\
/usr/bin/firefox\n\
cp -r -f /home/firefox/* /firefox/\n\
' > /startapp.sh

RUN chmod +x /startapp.sh
