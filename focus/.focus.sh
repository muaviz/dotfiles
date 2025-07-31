#!/usr/bin/env zsh

# CONFIGURATION
AUDIO_FILE="$HOME/Downloads/focus.mp3"
DEFAULT_DURATION_MIN=90
DELAY_BEFORE_START=10

# ICONS
ICON_START=""
ICON_DONE=""
ICON_WARN=""
ICON_MUSIC=""
ICON_TIMER=""
ICON_SKY=""

# Read duration from argument (in minutes) and validate
if [[ -n "$1" ]] && [[ "$1" =~ '^[0-9]+$' ]]; then
  SESSION_DURATION=$(( $1 * 60 ))
else
  if [[ -n "$1" ]]; then
    echo "$ICON_WARN Invalid duration '$1'. Using default: $DEFAULT_DURATION_MIN minutes."
  fi
  SESSION_DURATION=$(( DEFAULT_DURATION_MIN * 60 ))
fi

# Cleanup function
cleanup() {
    echo
    echo "$ICON_DONE Focus session ended. Cleaning up..."

    [[ -n "$MPV_PID" ]] && kill "$MPV_PID" 2>/dev/null

    if [[ -n "$TIMER_PID" ]]; then
        kill "$TIMER_PID" 2>/dev/null
    fi

    exit 0
}

# Trap signals
trap cleanup INT TERM

# Countdown before session starts
echo -n "$ICON_WARN Starting focus session in: "
for ((i=DELAY_BEFORE_START; i>0; i--)); do
    echo -ne "\r$ICON_WARN Starting focus session in: $i  "
    sleep 1
done
echo -e "\r$ICON_WARN Starting focus session now!     "

# Start background music
if [[ -f "$AUDIO_FILE" ]]; then
  echo "$ICON_MUSIC Playing focus music..."
  mpv --no-video --loop "$AUDIO_FILE" &>/dev/null &
  MPV_PID=$!
else
  echo "$ICON_WARN Audio file not found: $AUDIO_FILE"
fi

# Start timer in background that will end the session
(
  sleep "$SESSION_DURATION"
  echo
  echo "$ICON_TIMER $((SESSION_DURATION / 60)) minutes over. Ending session..."
  kill -TERM $$
) &
TIMER_PID=$!

# Start terminal-rain in foreground
echo "$ICON_SKY Launching terminal rain..."
if command -v terminal-rain &>/dev/null; then
    terminal-rain --lightning-color white
else
    echo "$ICON_WARN 'terminal-rain' command not found"
fi

# If user exits terminal-rain manually, cleanup
cleanup
