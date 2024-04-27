set -l current (commandline --tokenize --current-process)
set -l tmpline $current[1] --bpaf-complete-rev=9 $current[2..]
if test (commandline --current-process) != (string trim (commandline --current-process))
    set tmpline $tmpline ""
end
source ( $tmpline | psub )
