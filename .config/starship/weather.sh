#!/bin/bash
# 每30分钟刷新一次天气，结果缓存到临时文件
# 使用 Open-Meteo（免费、无需 API Key、更稳定）
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
    # 从 ipinfo.io 获取位置信息
    location=$(curl -s --max-time 3 "ipinfo.io/json" 2>/dev/null)
    lat=$(echo "$location" | grep '"lat"' | grep -oE '[0-9.-]+' | head -1)
    lon=$(echo "$location" | grep '"lon"' | grep -oE '[0-9.-]+' | head -1)
    # ipinfo.io 返回的是 "loc": "41.85,-87.65" 格式
    loc=$(echo "$location" | grep '"loc"' | grep -oE '[0-9.-]+,[0-9.-]+')
    if [ -z "$lat" ] && [ -n "$loc" ]; then
        lat=$(echo "$loc" | cut -d',' -f1)
        lon=$(echo "$loc" | cut -d',' -f2)
    fi
    city=$(echo "$location" | grep '"city"' | sed 's/.*"city": *"\([^"]*\)".*/\1/')

    if [ -n "$lat" ] && [ -n "$lon" ]; then
        # 调用 Open-Meteo 获取当前温度和天气码
        weather_json=$(curl -s --max-time 5 \
            "https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current=temperature_2m,weathercode&temperature_unit=celsius" \
            2>/dev/null)
        temp=$(echo "$weather_json" | grep -oE '"temperature_2m": *[0-9.-]+' | grep -oE '[0-9.-]+$')
        code=$(echo "$weather_json" | grep -oE '"weathercode": *[0-9]+' | grep -oE '[0-9]+$')

        if [ -n "$temp" ] && [ -n "$code" ]; then
            # 根据 WMO 天气码映射 emoji
            if   [ "$code" -eq 0 ];                          then icon="☀️"
            elif [ "$code" -le 2 ];                          then icon="⛅"
            elif [ "$code" -le 3 ];                          then icon="☁️"
            elif [ "$code" -le 49 ];                         then icon="🌫️"
            elif [ "$code" -le 59 ];                         then icon="🌦️"
            elif [ "$code" -le 69 ];                         then icon="🌧️"
            elif [ "$code" -le 79 ];                         then icon="🌨️"
            elif [ "$code" -le 84 ];                         then icon="🌧️"
            elif [ "$code" -le 99 ];                         then icon="⛈️"
            else                                              icon="🌡️"
            fi

            temp_rounded=$(printf "%.0f" "$temp")
            echo -n "${icon} ${temp_rounded}°C ${city:-?}" > "$CACHE_FILE"
        fi
    fi
fi
