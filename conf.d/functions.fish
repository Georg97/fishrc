function get_batp
    set -l battery_dir (find /sys/class/power_supply/ -name "BAT*" | head -n1)
    if test -n "$battery_dir"
        echo (cat "$battery_dir/capacity")%; and echo ""
    end
end

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end