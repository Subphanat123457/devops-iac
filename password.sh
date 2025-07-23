#!/bin/bash

generate_password() {
  # Default config
  local LENGTH=14
  local USE_SYMBOLS=false
  local USE_LOWER=true
  local USE_UPPER=true
  local USE_NUMBER=true

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --length|-l)
        LENGTH="$2"
        shift 2
        ;;
      --symbol|-s)
        USE_SYMBOLS=true
        shift
        ;;
      --no-lower)
        USE_LOWER=false
        shift
        ;;
      --no-upper)
        USE_UPPER=false
        shift
        ;;
      --no-number)
        USE_NUMBER=false
        shift
        ;;
      *)
        echo "❌ Unknown option: $1"
        return 1
        ;;
    esac
  done

  local CHAR_POOL=""

  $USE_LOWER && CHAR_POOL+="abcdefghijklmnopqrstuvwxyz"
  $USE_UPPER && CHAR_POOL+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  $USE_NUMBER && CHAR_POOL+="0123456789"
  $USE_SYMBOLS && CHAR_POOL+="!@#$%^&*()-_=+[]{}|:,.<>?"

  if [[ -z "$CHAR_POOL" ]]; then
    echo "❌ Error: No character type selected"
    return 1
  fi

  # Generate password
  tr -dc "$CHAR_POOL" < /dev/urandom | head -c "$LENGTH"
  echo
}
