#!/bin/bash

battery_lvl() (
	source /sys/class/power_supply/axp20x-battery/uevent
	echo $(( $POWER_SUPPLY_ENERGY_NOW * 100 / $POWER_SUPPLY_ENERGY_FULL ))
)
brightness_lvl() { cat /sys/class/backlight/backlight@0/actual_brightness; }
volume_lvl() { awk -F'[]%[]' '/Left:/ { print $2 }' <(amixer sget Master); }
volume_status() { awk -F'[]%[]' '/Left:/ { print $5 }' <(amixer sget Master); }
battery_status() { cat /sys/class/power_supply/axp20x-battery/status; }
bluetooth_status() { hciconfig hci0 | sed -n '3 p' | tr -d \\t; }
wifi_status() { echo ""; }

battery_icon() {
	if [ "$2" == "Charging" ]; then
		if [ "$1" -ge 90 ]; then echo '󱊦';
		elif [ "$1" -ge 50 ]; then echo '󱊥';
		elif [ "$1" -ge 10 ]; then echo '󱊤';
		else echo '󰢟';
		fi
	else
		if [ "$1" -ge 90 ]; then echo '󱊣';
		elif [ "$1" -ge 50 ]; then echo '󱊢';
		elif [ "$1" -ge 10 ]; then echo '󱊡';
		else echo '󰂎';
		fi
	fi
}

volume_icon() {
	if [ "$2" == "off" ]; then echo '󰝟';
	elif [ "$1" -ge 80 ]; then echo '󰕾';
	elif [ "$1" -ge 30 ]; then echo '󰖀';
	else echo '󰕿';
	fi
}

brightness_icon() {
	if [ "$1" -le 3 ]; then echo '󰃞';
	elif [ "$1" -le 6 ]; then echo '󰃟';
	else echo '󰃠';
	fi
}

bluetooth_icon() {
	if [ "$1" == "UP" ]; then echo '󰂯';
	elif [ "$1" == "DOWN" ]; then echo '󰂲';
	fi
}

wifi_icon() {
	WIFI_IWD_NTERFACE='/net/connman/iwd/0/2'
	IS_WIFI_POWERED=$(
		busctl get-property \
			net.connman.iwd \
			$WIFI_IWD_NTERFACE \
			net.connman.iwd.Device \
			Powered \
		| cut -d' ' -f2
	)
	WIFI_STATION_STATE=$(
		busctl get-property \
			net.connman.iwd \
			$WIFI_IWD_NTERFACE \
			net.connman.iwd.Station \
			State \
		| cut -d' ' -f2

	)
	if [ "$IS_WIFI_POWERED" == "true" ]; then
		if [ "$WIFI_STATION_STATE" == '"connected"' ]; then echo '󰖩';
		else echo '󱛅';
		fi
	else
		echo '󰖪';
	fi
}


# JSON generation starts here
echo '{"version": 1}'
echo "["

while true; do
BATTERY_LVL=$(battery_lvl)
BATTERY_STATUS=$(battery_status)
VOLUME_LVL=$(volume_lvl)
VOLUME_STATUS=$(volume_status)
BRIGHTNESS_LVL=$(brightness_lvl)
cat << EOT
[
	{
		"name": "bluetooth",
		"full_text": "$(bluetooth_icon $(bluetooth_status)) ",
		"urgent": false,
		"separator": true
	},
	{
		"name": "wifi",
		"full_text": "$(wifi_icon $(wifi_status)) ",
		"urgent": false,
		"separator": true
	},
	{
		"name": "brightness",
		"full_text": "$(brightness_icon $BRIGHTNESS_LVL) $BRIGHTNESS_LVL",
		"urgent": false,
		"separator": true
	},
	{
		"name": "volume",
		"full_text": "$(volume_icon $VOLUME_LVL $VOLUME_STATUS) $VOLUME_LVL%",
		"urgent": false,
		"separator": true	
	},
	{
		"name": "battery",
		"full_text": "$(battery_icon $BATTERY_LVL $BATTERY_STATUS) $BATTERY_LVL%",
		"urgent": $([[ $BATTERY_LVL -gt 5 ]] && echo false || echo true),
		"separator": true
	},
	{
		"name": "calendar",
		"full_text": "󰃭 $(date +'%Y-%m-%d')",
		"urgent": false,
		"separator": false
	},
	{
		"name": "clock",
		"full_text": "$(date +'%H:%M:%S')",
		"urgent": false,
		"separator": true
	}
],
EOT
sleep 1
done

echo "]" # We'll never reach that point...
