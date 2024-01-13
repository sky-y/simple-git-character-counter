#!/bin/bash -eu

### Definition
wcOpt="-m"           # wc option: charactor base
cachedOpt="--cached" # compare staged files
from="HEAD"
to=""

### Create help (-h | --help)
function usage {
  cat <<EOM
Description:
  This is a shell script to count the number of additional characters from the git diff results

Usage:
  $(basename "$0") [OPTION]...

Options:
  -f  [n|char|date]   Startpoint for comparison. n times before or hash (40|7 digit) or by date (date expression or ISO date). Default is HEAD.
  -t  [n|char|date]   Endpoint point for comparison. The format is the same as -f. Default is Staging.
  -s                  Compare -f startpoint with staged files. [Default]
  -u                  Compare -f startpoint with the working tree (unstaged files).
  -w                  Count words instead of characters
  -h                  Display this help

Documentation can be found at https://github.com/sky-y/simple-git-character-counter
EOM

  exit 1
}

### Process definition by argument
while getopts ":f:t:wsuh" optKey; do
  case "$optKey" in
    f)
      # hash checking
      if expr "$OPTARG" : "[a-f0-9]\{40\}$" >&/dev/null || expr "$OPTARG" : "[a-f0-9]\{7\}$" >&/dev/null; then
        from="${OPTARG}"
      # numeric checking
      elif expr "$OPTARG" : "[0-9]*$" >&/dev/null; then
        from="@~${OPTARG}"
      # date
      else
        from="@{${OPTARG}}"
      fi
      ;;
    t)
      # hash checking
      if expr "$OPTARG" : "[a-f0-9]\{40\}$" >&/dev/null || expr "$OPTARG" : "[a-f0-9]\{7\}$" >&/dev/null; then
        to="${OPTARG}"
      # numeric checking
      elif expr "$OPTARG" : "[0-9]*$" >&/dev/null; then
        to="@~${OPTARG}"
      # date
      else
        to="@{${OPTARG}}"
      fi
      ;;
    w)
      wcOpt="-w"
      ;;
    s)
      # staged
      cachedOpt="--cached"
      ;;
    u)
      # unstaged (on working tree)
      cachedOpt=""
      ;;
    h)
      usage
      ;;
    *)
      echo "[ERROR] Undefined options."
      echo "  Please check the Usage"
      echo ""
      usage
      ;;
  esac
done

### Main
git diff -p -b -w -U0 --diff-filter=AM --ignore-cr-at-eol --ignore-space-at-eol --ignore-blank-lines $cachedOpt "$from" $to | grep ^+ | grep -v ^+++ | sed s/^+// | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n//g' | wc $wcOpt