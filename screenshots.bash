#!/bin/bash
# Loops MacOS screencapture as a tool for creating animated gifs
program="$(basename "$0")"
die() {
    echo "${program}: $1"
    exit 1
}
usage() {
    die "usage: [-R top,left,width,height] [-T delayTime] baseFilename"
}
command -v screencapture &>/dev/null || die "requires MacOS util screencapture"

while getopts ":n:T:R:" opt; do
    case "$opt" in
      n) numberOfShots="$OPTARG";;
      R) rectangle="$OPTARG";;
      T) delay="$OPTARG";;
     \?) echo "unknown argument $opt"
         usage;;
    esac
done
shift $((OPTIND - 1))

[[ -z $1 ]] && usage
baseFilename="$1"
# screencapture options
# -R top,left,width,height Capture rectangle
# -x                       Do not play sounds
# -m                       Only capture main monitor
# -T seconds               Delay of seconds
numberOfShots=${numberOfShots:-2}
for ((shot = 0; shot < numberOfShots; ++shot)); do
    filename="${baseFilename}_${shot}.png"
    screencapture -T "${delay:-3}" -R "${rectangle:-0,0,1000,500}" "$filename"
    echo "captured $filename"
done