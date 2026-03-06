#!/bin/bash
# =============================================================================
#  universal_control.sh — Toggle Universal Control on macOS Tahoe (and later)
#
#  Usage:
#    ./universal_control.sh          # toggle (on → off, off → on)
#    ./universal_control.sh on       # enable Universal Control
#    ./universal_control.sh off      # disable Universal Control
#    ./universal_control.sh status   # print current state
# =============================================================================

PLIST_DOMAIN="com.apple.universalcontrol"
PLIST_KEY="Enabled"

# ── helpers ──────────────────────────────────────────────────────────────────

get_state() {
  # Returns 1 (enabled) or 0 (disabled / key missing)
  local val
  val=$(defaults read "$PLIST_DOMAIN" "$PLIST_KEY" 2>/dev/null)
  if [[ "$val" == "1" ]]; then
    echo "1"
  else
    echo "0"
  fi
}

apply_state() {
  local target="$1"   # "1" = enable, "0" = disable

  defaults write "$PLIST_DOMAIN" "$PLIST_KEY" -bool "$( [[ $target == "1" ]] && echo true || echo false )"

  # Restart the UniversalControl agent so the change takes effect immediately
  if pgrep -xq "UniversalControl"; then
    pkill -x "UniversalControl" 2>/dev/null
    sleep 0.5
    # macOS relaunches the agent automatically via launchd
  fi

  # Refresh Control Centre so the menu-bar icon updates
  if pgrep -xq "ControlCenter"; then
    pkill -x "ControlCenter" 2>/dev/null
  fi
}

print_status() {
  local state
  state=$(get_state)
  if [[ "$state" == "1" ]]; then
    echo "✅  Universal Control is currently ON  (keyboard & mouse are shared)"
  else
    echo "🔴  Universal Control is currently OFF (keyboard & mouse are NOT shared)"
  fi
}

# ── main ─────────────────────────────────────────────────────────────────────

ACTION="${1:-toggle}"

case "$ACTION" in
  on|enable)
    echo "Enabling Universal Control…"
    apply_state "1"
    print_status
    ;;
  off|disable)
    echo "Disabling Universal Control…"
    apply_state "0"
    print_status
    ;;
  status)
    print_status
    ;;
  toggle)
    CURRENT=$(get_state)
    if [[ "$CURRENT" == "1" ]]; then
      echo "Universal Control is ON → turning OFF…"
      apply_state "0"
    else
      echo "Universal Control is OFF → turning ON…"
      apply_state "1"
    fi
    print_status
    ;;
  *)
    echo "Usage: $0 [on|off|status|toggle]"
    exit 1
    ;;
esac
