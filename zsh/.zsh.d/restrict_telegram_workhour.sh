#!/usr/bin/env bash

_CMD="/usr/bin/telegram-desktop -workdir /home/nhamlh/.local/share/TelegramDesktop/ -- %u"

_RESTRICT_START=$(date --date "08:30" +%s)
_RESTRICT_END=$(date --date "14:30" +%s)

_NOW=$(date +%s)

if [ $_NOW -gt $_RESTRICT_START ] && [ $_NOW -lt $_RESTRICT_END ]; then
  notify-send "TELEGRAM IS RESTRICTED AT THE MOMENT"
  exit 1
fi

$_CMD
