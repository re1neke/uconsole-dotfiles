if [ "$(tty)" = "/dev/tty1" ]; then
	export XDG_SESSION_TYPE=wayland
	export XDG_SESSION_DESKTOP=sway
	export XDG_CURRENT_DESKTOP=sway

	export QT_QPA_PLATFORM=wayland

	export SDL_VIDEODRIVER=wayland

	export MOZ_ENABLE_WAYLAND=1
	export MOZ_WEBRENDER=1

	exec sway
fi
