
#!/bin/bash

LOCKFILE="/tmp/whisper-recording.lock"
AUDIO_PATH="/tmp/record.wav"
MODEL_PATH="$HOME/whisper/whisper.cpp/models/ggml-base.en.bin"
WHISPER_BIN="$HOME/whisper/whisper.cpp/build/bin/whisper-cli"

if [ ! -f "$LOCKFILE" ]; then
  echo "Recording started..."
  arecord -f cd -t wav -r 16000 -c 1 "$AUDIO_PATH" &
  echo $! > "$LOCKFILE"
else
  echo "Recording stopped."
  PID=$(cat "$LOCKFILE")
  kill "$PID"
  rm "$LOCKFILE"

  echo "Transcribing..."
  "$WHISPER_BIN" -m "$MODEL_PATH" -f "$AUDIO_PATH" -otxt

  if [ -f "${AUDIO_PATH}.txt" ]; then
    TEXT=$(cat "${AUDIO_PATH}.txt")
    echo "✅ Transcription: $TEXT"

    # install xdotool if not already installed
    xdotool type --delay 1 "$TEXT"
    echo "✅ Transcription typed into focused window."
  else
    echo "❌ Transcription failed — no output file."
  fi
fi
