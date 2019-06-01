#!/bin/sh

mkdir -p /downloads
mkdir -p /media
mkdir -p /config/logs

touch /config/logs/amc.log
touch /config/logs/watch.log
touch /config/logs/configure.log
touch /config/amc_exclude_list.txt

chmod u+x /filebot.sh
chmod u+x /postprocess.sh

if [ -f /config/osdb.txt ]; then
	echo "-------------[OPENSUBTITLES LOGIN]-------------" >> /config/logs/configure.log
	cat /config/osdb.txt | filebot -script fn:configure >> /config/logs/configure.log
fi

if [ -f chmod u+x /config/filebot.sh ]; then
	chmod u+x /config/filebot.sh
fi

if [ -f chmod u+x /config/postprocess.sh ]; then
	chmod u+x /config/postprocess.sh
fi

run_filebot() {
   if [ -f /config/filebot.sh ]; then
      sh /config/filebot.sh
   else
      sh /filebot.sh
   fi

   if [ -f /config/postprocess.sh ]; then
      sh /config/postprocess.sh
   else
      sh /postprocess.sh
   fi

   sleep 1
}

run_filebot

while true; do
   inotifywait -q --timefmt '%F %T' --format "[%T][%e]: %f" -e create,moved_to -r /downloads -o /config/logs/watch.log 
   run_filebot
done
