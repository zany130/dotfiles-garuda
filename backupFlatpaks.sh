#!/usr/bin/env bash
flatpak list --app --columns=origin --columns=application | awk '{print "flatpak install " $1,$2 " -y"}' > flatpaks.sh
