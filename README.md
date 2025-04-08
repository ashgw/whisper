A one-step configuration script for setting up Whisper with voice recording and automatic clipboard copying functionality on Linux.

## Quick Setup

Run this:

```bash
bash <(curl -s https://raw.githubusercontent.com/ashgw/whisper/refs/heads/main/run.sh)
```

Then follow the prompts to select your preferred model size:

- Base: Fastest, least accurate
- Medium: Balanced performance
- Large: Slowest, most accurate

## Usage

# Terminal

After installation, you can use the `whisperclip` command in your terminal:

1. Run `whisperclip` in your terminal
2. Speak into your microphone
3. Press Ctrl+C to stop recording
4. Wait for transcription
5. The text will be automatically copied to your clipboard!

# Keyboard Shortcut

Or you can set up a keyboard shortcut to run this command. I personally use `alt+w`.

Take a look at `toggle.sh` for more details.
give the file execution permissions by running `chmod +x toggle.sh`, put it somewhere where you can run it from your terminal.
for example `~/.local/bin/toggle.sh`
the command to run it would be `bash ~/.local/bin/toggle.sh`, then paste this command into your keyboard shortcut.

when you run the command, it will start recording your voice and transcribe it until you run the command again, then it will copy the transcription to your clipboard.

press alt + p to record, keep yaopping, then press alt + p again to stop recording.

## How It Works

The setup script:

1. Creates a whisper directory in your home folder
2. Clones and builds whisper.cpp
3. Downloads your chosen model
4. Adds the `whisperclip` function to your shell configuration
5. Installs any missing dependencies

The `whisperclip` function:

1. Records audio using `arecord`
2. Transcribes using Whisper.cpp
3. Automatically copies the transcription to your clipboard

## Troubleshooting

If you encounter any issues:

1. Check if the model was downloaded correctly
2. Verify your microphone is working with `arecord -l`
3. Ensure xclip is running with your display server

## License

MIT
