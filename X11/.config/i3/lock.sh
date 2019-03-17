#!/usr/bin/env bash

# Purpose: send dbus message to lock keepassXC database, then call i3lock

qdbus org.keepassxc.KeePassXC.MainWindow /keepassxc org.keepassxc.MainWindow.lockAllDatabases
i3lock -c 000000 -e
