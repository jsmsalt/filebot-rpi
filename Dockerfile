FROM jsmsalt/java-rpi:latest

MAINTAINER Jose Morales <jsmsalt@gmail.com>

# Environment variables.
ENV TZ=UTC

# System config
RUN echo "********** [SET LOCALTIME AND TIMEZONE] **********" \
	&& apk add --update --no-cache \
		tzdata \
	&& cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
	&& echo "$TZ" >  /etc/timezone \
	&& apk del tzdata

# Full installation.
RUN echo "********** [INSTALLING DEPENDENCIES] **********" \
	&& apk add --update --no-cache --virtual build-dependencies \
		xz \
		tar \
		curl \
		ca-certificates \
	&& apk add --no-cache \
		inotify-tools \
	\
	\
	&& echo "********** [INSTALLING FILEBOT] **********" \
	&& mkdir -p /opt/share/filebot \
	&& cd /opt/share/filebot \
	&& curl -s -L -o filebot.tar.xz https://sourceforge.net/projects/filebot/files/filebot/FileBot_4.7.9/FileBot_4.7.9-portable.tar.xz/download \
	&& chmod 777 filebot.tar.xz \
	&& tar xvf filebot.tar.xz \
	&& ln -sf /opt/share/filebot/filebot.sh /usr/local/bin/filebot \
	\
	\
	&& echo "********** [CLEAN UP] **********" \
	&& apk del build-dependencies \
	&& rm filebot.tar.xz \
	&& rm filebot.portable.launcher.exe \
	&& rm filebot.portable.launcher.l4j.ini \
	&& rm filebot.cmd \
	&& rm update-filebot.sh \
	&& rm -rf \
		/tmp/* \
		/var/tmp/* \
		/var/cache/apk/* \
		/opt/share/filebot/lib/x86_64/* \
		/opt/share/filebot/lib/i686/* \
		/opt/share/filebot/lib/aarch64/*

# Set volumes.
VOLUME /downloads /media /config

# Copy scripts.
COPY start.sh /start.sh
COPY filebot.sh /filebot.sh
COPY postprocess.sh /postprocess.sh
RUN chmod +x /start.sh \
	&& chmod +x /filebot.sh \
	&& chmod +x /postprocess.sh

# Define default entrypoint.
ENTRYPOINT ["/start.sh"]