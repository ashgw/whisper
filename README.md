# Whisper CLI Setup

A one-step configuration script for setting up Whisper.cpp with voice recording and automatic clipboard copying functionality Linux.

## Quick Setup

1. Clone this repository:
2. Follow the prompts to select your preferred model size:
   - Base: Fastest, least accurate
   - Medium: Balanced performance
   - Large: Slowest, most accurate

## Usage

After installation, you can use the `whisperclip` command in your terminal:

1. Run `whisperclip` in your terminal
2. Speak into your microphone
3. Press Ctrl+C to stop recording
4. Wait for transcription
5. The text will be automatically copied to your clipboard!

or you can setup a keyboard shortcut to run this command, for me I do `alt+p`

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

1. Make sure all dependencies are installed
2. Check if the model was downloaded correctly
3. Verify your microphone is working with `arecord -l`
4. Ensure xclip is running with your display server

## License

[Your License Here]
