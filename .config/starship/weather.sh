#!/bin/bash
# 每30分钟刷新一次天气，结果缓存到临时文件
CACHE_FILE="/tmp/.starship_weather"
CACHE_TTL=1800  # 秒

now=$(date +%s)
if [ -f "$CACHE_FILE" ]; then
    modified=$(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)
    age=$(( now - modified ))
else
    age=$CACHE_TTL
fi

if [ "$age" -ge "$CACHE_TTL" ]; then
    weather=$(curl -s --connect-timeout 3 "wttr.in/?format=%c+%t&m" 2>/dev/null | tr -d '\n')
    [ -n "$weather" ] && echo "$weather" > "$CACHE_FILE"
fi
