# Whisper Toggle (Linux)

One-step setup for whisper with live mic recording and auto-clipboard transcription.

## Quick Setup

```bash
bash <(curl -s https://raw.githubusercontent.com/ashgw/whisper/refs/heads/main/setup)
````

Pick your model size:

* **Base** – fastest
* **Medium** – balanced
* **Large** – most accurate

## Usage
Run:

```bash
w
```
* Speak into your mic
* Press **Ctrl+C** to stop
* Transcription is copied to your clipboard

### Keybind Toggle

Install the toggle script:

```bash
chmod +x ~/.local/bin/toggle
```

Bind it to a key (example `Alt+W`).

Using Hyprland for example:
```ini
bind = ALT, W, exec, /home/youruser/.local/bin/toggle
```

Reload config:

```bash
hyprctl reload
```

Now:

* **First press** → start recording
* **Second press** → stop + transcribe + copy

## Troubleshooting

* Ensure your model exists in `~/.local/share/whisper/models`
* Check mic devices: `arecord -l`
* Clipboard requires `wl-copy` (Wayland) or `xclip` (X11)

## License

MIT

