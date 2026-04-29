if [ "$1" == "toggle" ]; then
    CURRENT=$(tuned-adm active | awk '{print $NF}')
    [ "$CURRENT" == "cachyos-gaming" ] && tuned-adm profile cachyos-powersave || tuned-adm profile cachyos-gaming
    exit 0
fi
PROFILE=$(tuned-adm active | awk '{print $NF}')

if [[ "$PROFILE" == "cachyos-powersave" ]]; then
    ICON=""
    CLASS="powersave"
elif [[ "$PROFILE" == "cachyos-gaming" ]]; then
    ICON=""
    CLASS="performance"
else
    ICON=""
    CLASS="default"
fi

echo "{\"text\": \"$ICON\", \"alt\": \"$CLASS\", \"icon\": \"$ICON\", \"class\": \"$CLASS\"}"

