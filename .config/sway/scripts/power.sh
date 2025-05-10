#!/bin/bash

ACTION=$(
	echo -e '󰤆  Shutdown\n󰑓  Restart\n󰗽  Logout' \
		| tofi \
			--width 22% \
			--height 23% \
			--padding-bottom=4% \
			--prompt-text '󰨃   '
)

case "$ACTION" in
	"󰤆  Shutdown") systemctl poweroff;;
	"󰑓  Restart") systemctl reboot;;
	"󰗽  Logout") swaymsg exit;;
esac
