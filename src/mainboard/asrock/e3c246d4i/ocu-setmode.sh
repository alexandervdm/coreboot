#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only

# e3c246d4i includes two OCuLink ports OCU1 (bottom) and OCU2 (top) that
# can be configured as SATA mode or PCIE mode by modifying pch soft-strap 
# registers written into the descriptor.bin:

#		both-sata	1sata/2pcie	1pcie/2sata	both-pcie
# ------------------------------------------------------------------------
# PCHSTRP2	0x00000000	0x0000ff00	0x000000ff	0x0000ffff
# PCHSTRP81	0x77775555	0x77775555	0xcccc5555	0xcccc5555
# PCHSTRP82	0x55557777	0x5555cccc	0x55557777	0x5555cccc
# PCHSTRP86	0x00ff0000	0x00ffff00	0x00ff00ff	0x00ffffff
# 
# Stock BIOS default = 1-pcie 2-sata

set -e

usage() {
	echo "Usage: $0 -1 <sata|pcie> -2 <sata|pcie> -i /path/to/ifdtool <descriptor_file>"
	exit 1
}

while getopts ":1:2:i:" opt; do
	case "$opt" in
		1) OCU1=$OPTARG ;;
		2) OCU2=$OPTARG ;;
		i) IFDTOOL=$OPTARG ;;
		:)
			echo "Error: -$OPTARG requires an argument." >&2
			usage ;;
		\?)
			echo "Error: invalid option -$OPTARG" >&2
			usage ;;
	esac
done

# oculink modes
case "${OCU1}_${OCU2}" in
	sata_sata)
		PCHSTRP2=0x00000000
		PCHSTRP81=0x77775555
		PCHSTRP82=0x55557777
		PCHSTRP86=0x00ff0000
		;;
	sata_pcie)
		PCHSTRP2=0x0000ff00
		PCHSTRP81=0x77775555
		PCHSTRP82=0x5555cccc
		PCHSTRP86=0x00ffff00
		;;
	pcie_sata)
		PCHSTRP2=0x000000ff
		PCHSTRP81=0xcccc5555
		PCHSTRP82=0x55557777
		PCHSTRP86=0x00ff00ff
		;;
	pcie_pcie)
		PCHSTRP2=0x0000ffff
		PCHSTRP81=0xcccc5555
		PCHSTRP82=0x5555cccc
		PCHSTRP86=0x00ffffff
		;;
	*)
		usage
		;;
esac

echo "* OCU1-mode  : $OCU1"
echo "* OCU2-mode  : $OCU2"

# ifdtool
if ! [ -x "$(command -v $IFDTOOL)" ]; then
	echo "Error: ifdtool not found at given path"
	exit 1
else
	echo "* ifdtool    : $IFDTOOL"
fi

# descriptor
shift $((OPTIND - 1))
IFD_IN=$1

if ! [ -f $IFD_IN ]; then
	echo "Error: descriptor not found at given path"
	exit 1
else
	IFD_OUT="${IFD_IN%.*}.$OCU1-$OCU2.${IFD_IN##*.}"
	echo "* IFD  input : $IFD_IN"
	echo "* IFD output : $IFD_OUT"
fi

# execute
$IFDTOOL -p cnl --setpchstrap  2 -V $PCHSTRP2  -O $IFD_OUT $IFD_IN
$IFDTOOL -p cnl --setpchstrap 81 -V $PCHSTRP81 -O $IFD_OUT $IFD_OUT
$IFDTOOL -p cnl --setpchstrap 82 -V $PCHSTRP82 -O $IFD_OUT $IFD_OUT
$IFDTOOL -p cnl --setpchstrap 86 -V $PCHSTRP86 -O $IFD_OUT $IFD_OUT

echo "* Descriptor with selected oculink modes written to"
echo "  $IFD_OUT"

