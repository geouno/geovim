#! /bin/sh
# Installation script, Debian
# sh -c "$(curl -fsSL https://gitlab.com/geouno/geovim/-/raw/main/geovim_install_Debian.sh)"

# Check if user can perform sudo commands
user_can_sudo() {
	# source https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh#L84
	! (LANG= sudo -n -v 2>&1 | grep -q "may not run sudo\|sudo: command not found\|sudo: not found")
}


if [ -t 1 ]; then
	is_tty() {
		true
	}
else
	is_tty() {
		false
	}
fi


supports_truecolor() {
	case "$COLORTERM" in
	truecolor|24bit) return 0 ;;
	esac

	case "$TERM" in
	iterm           |\
	tmux-truecolor  |\
	linux-truecolor |\
	xterm-truecolor |\
	screen-truecolor) return 0 ;;
	esac

	return 1
}


setup_color() {
	# Only use colors if connected to a terminal
	if ! is_tty; then
		FMT_ROSEPINE=""
		FMT_RAINBOW=""
		FMT_RED=""
		FMT_GREEN=""
		FMT_YELLOW=""
		FMT_BLUE=""
		FMT_MAGENTA=""
		FMT_PINK=""
		FMT_CYAN=""
		FMT_BOLD=""
		FMT_RESET=""
		FMT_ROSEPINE_DAWN_BASE=""
		return
	fi

	if supports_truecolor; then
		FMT_RAINBOW="
			$(printf '\033[38;2;255;0;0m')
			$(printf '\033[38;2;255;97;0m')
			$(printf '\033[38;2;247;255;0m')
			$(printf '\033[38;2;0;255;30m')
			$(printf '\033[38;2;77;0;255m')
			$(printf '\033[38;2;168;0;255m')
			$(printf '\033[38;2;245;0;172m')
		"
		FMT_ROSEPINE="
			$(printf '\033[38;2;235;111;146m')
			$(printf '\033[38;2;234;154;151m')
			$(printf '\033[38;2;246;193;119m')
			$(printf '\033[38;2;156;207;216m')
			$(printf '\033[38;2;62;143;176m')
			$(printf '\033[38;2;196;167;231m')
		"
		FMT_RED=$(printf '\033[38;2;235;111;146m')
		FMT_YELLOW=$(printf '\033[38;2;246;193;119m')
		FMT_GREEN=$(printf '\033[38;2;156;207;216m')
		FMT_BLUE=$(printf '\033[38;2;62;143;176m')
		FMT_MAGENTA=$(printf '\033[38;2;196;167;231m')
		FMT_PINK=$(printf '\033[38;2;234;154;151m')
		FMT_ROSEPINE_DAWN_BASE=$(printf '\033[38;2;250;244;237m')

	else
		FMT_RAINBOW="
			$(printf '\033[38;5;196m')
			$(printf '\033[38;5;202m')
			$(printf '\033[38;5;226m')
			$(printf '\033[38;5;082m')
			$(printf '\033[38;5;021m')
			$(printf '\033[38;5;093m')
			$(printf '\033[38;5;163m')
		"
		# FMT_ROSEPINE=$FMT_RAINBOW
		FMT_RED=$(printf '\033[31m')
		FMT_YELLOW=$(printf '\033[33m')
		FMT_GREEN=$(printf '\033[32m')
		FMT_BLUE=$(printf '\033[34m')
		FMT_MAGENTA=$(printf '\033[35m')
		FMT_CYAN=$(printf '\033[36m')
		FMT_ROSEPINE_DAWN_BASE=$(printf '\033[37m')

		FMT_ROSEPINE="
			$FMT_RED
			$FMT_YELLOW
			$FMT_GREEN
			$FMT_CYAN
			$FMT_BLUE
			$FMT_MAGENTA
		"
	fi

	FMT_BOLD=$(printf '\033[1m')
	FMT_RESET=$(printf '\033[0m')
}


print_success() {
	printf '\n'
	printf '%s%s       g   %se   %so   %su   %sn   %so%s\n' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s       %s     %s    %s      %s _%s\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s       %s     %s    %s      %s(_)%s\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s  __ _ %s ___ %s ___%s__   __%s_%s _ __ ___\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s / _` |%s/ _ \%s/ _ \%s \ / /%s |%s \047_ ` _ \\\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s| (_| |%s  __/%s (_) \%s - /%s| |%s | | | | |\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s \__, |%s\___|%s\___/%s \_/%s |_|%s_| |_| |_|\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s  __/ |%s%s%s%s%s\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s |___/%s%s%s%s%s%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	if supports_truecolor; then
		printf '%s          ...is %snow %sinstalled!\n%s' $FMT_GREEN $FMT_BLUE $FMT_MAGENTA $FMT_RESET
	else
		printf '%s          ...is %snow %sinstalled!\n%s' $FMT_CYAN $FMT_BLUE $FMT_MAGENTA $FMT_RESET
	fi
	printf '\n'
}

already_installed() {
	! (LANG= nvim -v 2>&1 | grep -q "nvim: command not found\|nvim: not found" &&
		LANG= geo -v 2>&1 | grep -q "geo: command not found\|geo: not found")
}

print_already_installed() {
	printf '\n'
	printf '%s%s       g   %se   %so   %su   %sn   %so%s\n' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s       %s     %s    %s      %s _%s\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s       %s     %s    %s      %s(_)%s\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s  __ _ %s ___ %s ___%s__   __%s_%s _ __ ___\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s / _` |%s/ _ \%s/ _ \%s \ / /%s |%s \047_ ` _ \\\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s| (_| |%s  __/%s (_) \%s - /%s| |%s | | | | |\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s \__, |%s\___|%s\___/%s \_/%s |_|%s_| |_| |_|\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s  __/ |%s%s%s%s%s\n%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	printf '%s%s |___/%s%s%s%s%s%s' $FMT_BOLD $FMT_ROSEPINE $FMT_RESET
	if supports_truecolor; then
		printf '%s      ...is%s alre%sady %sinstalled!\n%s' $FMT_YELLOW $FMT_GREEN $FMT_BLUE $FMT_MAGENTA $FMT_RESET
	else
		printf '%s      ...is%s alre%sady %sinstalled!\n%s' $FMT_GREEN $FMT_CYAN $FMT_BLUE $FMT_MAGENTA $FMT_RESET
	fi
	printf '\n'
}


main() {
	setup_color

	if already_installed; then
		print_already_installed

		return
	fi

	# Install prerequisites
	printf '\n%s%sVerifying prerequisites...%s\n\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	if user_can_sudo; then
		printf '%s%s\tUpdating package index...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
		sudo apt-get update -q 1> /dev/null
		printf '%s%s\tUpgrading prerequisites...%s\n\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
		sudo apt-get -qq install git gettext libtool libtool-bin\
			autoconf automake cmake g++ pkg-config unzip curl 1> /dev/null 2> /dev/null
		sudo apt-get -q upgrade git gettext libtool libtool-bin\
			autoconf automake cmake g++ pkg-config unzip curl
	else
		printf '%s%s\tUpdating package index...%s\n\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
		apt-get update -q 1> /dev/null
		printf '%s%s\tUpgrading prerequisites...%s\n\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
		apt-get -qq install git gettext libtool libtool-bin\
			autoconf automake cmake g++ pkg-config unzip curl 1> /dev/null 2> /dev/null
		apt-get -q upgrade git gettext libtool libtool-bin\
			autoconf automake cmake g++ pkg-config unzip curl
	fi
	printf '\n%s%sDone. Prerequisites verified and upgraded.%s\n\n' $FMT_BOLD $FMT_GREEN $FMT_RESET

	local TEMPDIR=/tmp/temporary_dir_geovim_`date +%F_%H_%M`

	# Build neovim from source
	printf '\n%s%sDownloading neovim repository...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	if ! git clone --quiet https://github.com/neovim/neovim\
		$TEMPDIR/neovim;
	then
		printf '\n%s%sAborted. Error encountered.%s\n' $FMT_BOLD $FMT_RED $FMT_RESET
		return;
	fi

	printf '\n%s%sDone. Repository downloaded.%s\n\n' $FMT_BOLD $FMT_GREEN $FMT_RESET
	cd $TEMPDIR/neovim
	git checkout stable 1> /dev/null 2> /dev/null

	printf '\n%s%sBuilding neovim... this may take a while...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	make --silent CMAKE_BUILD_TYPE=Release 1> /dev/null 2> /dev/null
	printf '\n%s%sDone. Build ready.%s\n' $FMT_BOLD $FMT_GREEN $FMT_RESET

	printf '\n%s%sInstalling binaries...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	if user_can_sudo; then
		sudo make install --silent 1> /dev/null 2> /dev/null
	else
		make install --silent 1> /dev/null 2> /dev/null
	fi
	printf '\n%s%sDone. Binaries installed.%s\n\n' $FMT_BOLD $FMT_GREEN $FMT_RESET

	# Configuration
	printf '\n%s%sDownloading packer...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	git clone --quiet https://github.com/wbthomason/packer.nvim\
		$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
	printf '\n%s%sDone. Packer downloaded.%s\n\n' $FMT_BOLD $FMT_GREEN $FMT_RESET

	printf '\n%s%sLoading configuration...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	local CONFDIR=$HOME/.config
	[ -z ${XDG_CONFIG_HOME} ] || CONFDIR=$XDG_CONFIG_HOME

	[ -d $HOME/.config ] || mkdir $HOME/.config
	[ -d $HOME/.config/nvim ] && mv $HOME/.config/nvim\
		$HOME/Documents/config_nvim_backup_`date +%F_%H_%M`

	printf '\n%s%sDownloading dotfiles...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	git clone --quiet https://gitlab.com/geouno/geovim\
		$TEMPDIR/geovim
	cp -r $TEMPDIR/geovim/config_nvim $CONFDIR/nvim
	printf '\n%s%sDone. Dotfiles loaded.%s\n\n' $FMT_BOLD $FMT_GREEN $FMT_RESET

	printf '\n%s%sDownloading and updating plugins...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	cp $TEMPDIR/geovim/util/first_time_setup_init.lua\
		$CONFDIR/nvim/init.lua
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	printf '\n%s%sDone. Plugins ready.%s\n\n' $FMT_BOLD $FMT_GREEN $FMT_RESET
	cp $TEMPDIR/geovim/config_nvim/init.lua\
		$CONFDIR/nvim/init.lua

	# Cleanup
	printf '\n%s%sCleaning up...%s\n' $FMT_BOLD $FMT_ROSEPINE_DAWN_BASE $FMT_RESET
	if user_can_sudo; then
		sudo rm -r $TEMPDIR
	else
		rm -r $TEMPDIR
	fi
	printf '\n%s%sDone. Cleared.%s\n' $FMT_BOLD $FMT_GREEN $FMT_RESET

	print_success
}

main "$@"

# "Effort does not go unnoticed, especially when it is all about going unnoticed."
