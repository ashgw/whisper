A one-step configuration script for setting up Whisper with voice recording and automatic clipboard copying functionality on Linux.

## Quick Setup

Run this:

```bash
bash <(curl -s https://raw.githubusercontent.com/ashgw/whisper/refs/heads/main/run)
```

Then follow the prompts to select your preferred model size:

- Base: Fastest, least accurate
- Medium: Balanced performance
- Large: Slowest, most accurate

## Usage

### Terminal

After installation, you can use the `whisperclip` command in your terminal to transcribe audio:

1. **Run the command**: Type `whisperclip` in your terminal and press Enter.
2. **Speak into your microphone**: Clearly articulate what you want to transcribe.
3. **Stop recording**: Press `Ctrl+C` to stop the recording.
4. **Wait for transcription**: The system will process your audio and generate the transcription.
5. **Automatic clipboard copy**: The transcribed text will be automatically copied to your clipboard for easy pasting.

### Keyboard Shortcut

You can also set up a keyboard shortcut to run the `whisperclip` command. Here's how:

1. **Choose a shortcut**: I personally use `Alt + W`.
2. **Set up the script**:
   - Place `toggle` in a directory accessible from your terminal, such as `~/.local/bin/`.
   - Give the file execution permissions by running:
     ```bash
     chmod +x toggle
     ```
3. **Run the command**: To execute the script, use:
   ```bash
   bash ~/.local/bin/toggle
   ```
4. **Configure your keyboard shortcut**: Paste the above command into your keyboard shortcut settings.

### Recording with the Shortcut

When you run the command using the keyboard shortcut, `Alt + W`:

- **Start recording**: Press `Alt + W` to begin recording your voice.
- **Stop recording**: Press `Alt + W` again to stop the recording. The transcription will be copied to your clipboard.

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

