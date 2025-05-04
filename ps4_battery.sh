#!/bin/bash

# Busqueda de mandos
ALL_DEVICES=$(upower -e | grep "battery" | while read device; do
    if upower -i "$device" | grep -qE "joystick|gamepad|Sony|Wireless Controller|PlayStation"; then
        echo "$device"
    fi
done)

# Icono para los mandos
ICON=""


OUTPUT=""
print_battery() {
  local DEVICE=$1
  local ICON=$2

  if ! upower -i "$DEVICE" &>/dev/null; then
    return
  fi

  BATTERY=$(upower -i "$DEVICE" | awk '/percentage/ { print $2 }')
  LEVEL=${BATTERY%%%}

  if [[ "$LEVEL" -eq 0 ]]; then
    return
  fi

  # Color segun el porcentaje de bateria
  if [[ "$LEVEL" -ge 80 ]]; then
      COLOR="%{F#00FF00}"  # Verde
  elif [[ "$LEVEL" -ge 50 ]]; then
      COLOR="%{F#FFFF00}"  # Amarillo
  elif [[ "$LEVEL" -ge 20 ]]; then
      COLOR="%{F#FFA500}"  # Naranja
  else
      COLOR="%{F#FF0000}"  # Rojo
  fi

  OUTPUT+="${ICON} ${COLOR}${BATTERY}%{F-} "
}

# Mostrar bateria de los mandos conectados
for DEVICE in $ALL_DEVICES; do
  print_battery "$DEVICE" "$ICON"
done

# Mostrar mandos
echo "${OUTPUT%" "}"
