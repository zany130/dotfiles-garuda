function full-upgrade --wraps='tldr --update && flatpak update && garuda-update -a && sudo fwupdmgr upgrade && plasma-discover-update && fisher update && echo done' --description 'alias full-upgrade=tldr --update && flatpak update && garuda-update -a && echo done'
  tldr --update && flatpak update && garuda-update -a && sudo waydroid upgrade && sudo fwupdmgr upgrade && plasma-discover-update && fisher update && echo done $argv
        
end
