# Echo's the operating system, but simplified to
# - osx
# - ubuntu

get_os() {
	# Identify the operating system.
	local un=$(uname -a)
	os="unknown"
	if [[ "$un" =~ [Dd]arwin ]]; then
		echo "osx"
	elif [[ "$un" =~ [Uu]buntu ]]; then
		echo "ubuntu"
	elif [[ "$un" =~ [Dd]ebian]]; then
		echo "Debian"
	else
		logger -s "Unable to identify operating system from uname '$un'"
		exit 1
	fi
}
