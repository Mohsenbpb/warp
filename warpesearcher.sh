#!/bin/bash

# رنگ‌ها
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
orange='\033[0;38;5;214m'  # نارنجی
rest='\033[0m'

case "$(uname -m)" in
x86_64 | x64 | amd64)
	cpu=amd64
	;;
i386 | i686)
	cpu=386
	;;
armv8 | armv8l | arm64 | aarch64)
	cpu=arm64
	;;
armv7l)
	cpu=arm
	;;
*)
	echo -e "${red}The current architecture is $(uname -m), not supported${rest}"
	exit
	;;
esac

# تابع برای دانلود warpendpoint
cfwarpIP() {
	if [[ ! -f "$PREFIX/bin/warpendpoint" ]]; then
		echo -e "${orange}Downloading warpendpoint program...${rest}"
		if [[ -n $cpu ]]; then
			curl -L -o warpendpoint -# --retry 2 "https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/$cpu"
			cp warpendpoint "$PREFIX/bin"
			chmod +x "$PREFIX/bin/warpendpoint"
		fi
	fi
}

# تابع برای تولید آدرس‌های IP
generate_ips() {
	local base_ips=("162.159.192" "162.159.193" "162.159.195" "188.114.96" "188.114.97" "188.114.98" "188.114.99")
	local n=0
	local iplist=100
	while [[ $n -lt $iplist ]]; do
		for base_ip in "${base_ips[@]}"; do
			temp[$n]=$(echo "$base_ip.$(($RANDOM % 256))")
			n=$((n + 1))
			if [[ $n -ge $iplist ]]; then
				break
			fi
		done
	done
}

# تابع برای نمایش نتایج
show_results() {
	echo -e "${purple}************************************${rest}"
	echo -e "${green}Results Saved in result.csv${rest}"
	# ادامه نمایش نتایج...
}

# منوی کاربری
menu() {
	clear
	echo -e "${cyan}By --> Peyman * Github.com/Ptechgithub * ${rest}"
	echo ""
	echo -e "${purple}**********************${rest}"
	echo -e "${purple}*  ${green}Endpoint Scanner ${purple} *${rest}"
	echo -e "${purple}*  ${green}wire-g installer ${purple} *${rest}"
	echo -e "${purple}*  ${green}License cloner${purple}    *${rest}"
	echo -e "${purple}**********************${rest}"
	echo -e "${purple}[1] ${cyan}Preferred${green} IPV4${purple}   * ${rest}"
	echo -e "${purple}[2] ${cyan}Preferred${green} IPV6${purple}   * ${rest}"
	echo -e "${purple}[3] ${cyan}Free Config ${green}Wgcf${purple} *${rest}"
	echo -e "${purple}[4] ${cyan}Install ${green}wire-g${purple}   *${rest}"
	echo -e "${purple}[5] ${cyan}License Cloner${purple}   *${rest}"
	echo -e "${purple}[${red}0${purple}] Exit             *${rest}"
	echo -e "${purple}**********************${rest}"
	echo -en "${cyan}Enter your choice: ${rest}"
	read -r choice
	case "$choice" in
	1)
		cfwarpIP
		generate_ips
		show_results
		;;
	2)
		# تابع مربوط به IPv6
		;;
	3)
		# تابع مربوط به Wgcf
		;;
	4)
		# تابع مربوط به wire-g
		;;
	5)
		# تابع مربوط به License Cloner
		;;
	0)
		echo -e "${purple}*********************${rest}"
		echo -e "${cyan}By ${rest}"
		exit
		;;
	*)
		echo -e "${yellow}********************${rest}"
		echo "Invalid choice. Please select a valid option."
		;;
	esac
}

# اجرای منو
menu
