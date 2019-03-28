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

while true; do
   inotifywait -q --timefmt '%F %T' --format "[%T][%e]: %f" -e create,moved_to -r /downloads -o /config/logs/watch.log 

   if [ -f /filebot.sh ]; then
      sh /filebot.sh
   fi

   if [ -f /postprocess.sh ]; then
      sh /postprocess.sh
   fi

   sleep 1
done
