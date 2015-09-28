#!/bin/bash

function regen() {
	cat example1.gv | dot -Tsvg > example1.svg
	# cat example1.gv | neato -Tsvg > example1.neato.svg
	activate ' - Google Chrome'
	xdotool key 'F5'
	xdotool key 'F5'
	activate ' - gedit'
}

function activate() {
	activate_name="$1"
	export activate_name
	WID=$(xdotool search --onlyvisible --name "$activate_name" | head -1)
	xdotool windowactivate --sync $WID
}

regen
inotifywait -me CLOSE_WRITE . | while read FILE_EVENT;
do
	echo $FILE_EVENT | grep example1.gv && regen
done

