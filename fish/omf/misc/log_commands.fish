# https://spin.atomicobject.com/2016/05/28/log-bash-history/
# http://stackoverflow.com/q/38485384/1216965

function log_commands --on-event fish_preexec
  if [ $argv ]
    # fish_preexec functions receive the commandline as the argument (see `function --help`)
    echo (date "+%Y-%m-%d %H:%M:%S") (pwd) $argv >> ~/.logs/history-(date "+%Y-%m-%d").log
  end
end

#function log_commands_1 --on-event fish_postexec
#  set prev_cmd_exit $status
#  if [ $argv ]
#    echo $prev_cmd_exit >> ~/.logs/history-(date "+%Y-%m-%d").log
#  end
#end

