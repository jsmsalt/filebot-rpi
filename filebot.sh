#!/bin/sh

# Folders
INPUT="/downloads"
OUTPUT="/media"

# Formats
# e.g. /media/movies/Titanic (1997)/Titanic.mp4
MOVIES_FORMAT="movieFormat=$OUTPUT/movies/{n} ({y})/{n}"

# e.g. /media/tvshows/Game of Thrones (2011)/Season 01/Game of Thrones s01e01.mp4
TVSHOWS_FORMAT="seriesFormat=$OUTPUT/tvshows/{n} ({y})/Season {s.pad(2)}/{n} {s00e00}"

# Example command. This will download all files and metadata,
# subtitles, rename all files and move them to the specified folders.
filebot -script fn:amc  \
	--output "$OUTPUT"  \
	--action move  \
	--conflict skip  \
	--lang "spa" \
	-get-subtitles \
	-non-strict  \
	--log-file /config/logs/amc.log \
	--def "$MOVIES_FORMAT" "$TVSHOWS_FORMAT"  \
	--def minFileSize=0  \
	--def minLengthMS=0  \
	--def subtitles=es,en  \
	--def artwork=y \
	--def clean=y \
	--def reportError=y \
	--def excludeList=/config/amc_exclude_list.txt \
	ut_dir="$INPUT"  \
	ut_kind="multi"
