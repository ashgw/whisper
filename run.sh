#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# these should be available on most linux distros
check_dependencies() {
    local missing_deps=()

    for dep in "git" "make" "gcc" "arecord" "xclip"; do
        if ! command -v $dep &> /dev/null; then
            missing_deps+=($dep)
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}Missing dependencies: ${missing_deps[*]}${NC}"
        echo -e "${YELLOW}Installing missing dependencies...${NC}"
        sudo apt-get update
        sudo apt-get install -y ${missing_deps[@]}
    fi
}

create_whisper_function() {
    local shell_rc="$1"
    local model_size="$2"

    cat >> "$shell_rc" << EOL

# u can run this from the terminal by typing whisperclip, if it doesn't show at first reload ur ~/.zshrc or ~/.bashrc file
whisperclip() {
    local AUDIO_PATH="/tmp/record.wav"
    local MODEL_PATH="\$HOME/whisper/whisper.cpp/models/ggml-${model_size}.en.bin"
    local WHISPER_BIN="\$HOME/whisper/whisper.cpp/main"

    echo -e "\e[1;34m🎙️ Recording... Press Ctrl+C to stop.\e[0m"

    arecord -f cd -t wav -r 16000 -c 1 "\$AUDIO_PATH" &
    local RECORD_PID=\$!

    trap "kill \$RECORD_PID; wait \$RECORD_PID 2>/dev/null; echo -e '\n🧠 Transcribing...'; \$WHISPER_BIN -m \$MODEL_PATH -f \$AUDIO_PATH -otxt && cat \${AUDIO_PATH}.txt && xclip -selection clipboard -i \${AUDIO_PATH}.txt && echo -e '\n✅ Done. Copied to clipboard.'; trap - INT" INT

    wait \$RECORD_PID
}
EOL
}

echo -e "${BLUE}🎯 Starting Whisper.cpp Setup${NC}"

echo -e "${YELLOW}Checking dependencies...${NC}"
check_dependencies

echo -e "${YELLOW}Creating whisper directory...${NC}"
mkdir -p ~/whisper
cd ~/whisper

echo -e "${YELLOW}Cloning whisper.cpp at pinned commit...${NC}"
git clone https://github.com/ggml-org/whisper.cpp
cd whisper.cpp
git checkout 040510a132f0a9b51d4692b57a6abfd8c9660696
echo -e "${YELLOW}Building whisper.cpp...${NC}"
make
>

# this model will be your base, run /models/download-ggml-model.sh medium.en for exmaple to get the model manually
# model types can be found here https://github.com/ggerganov/whisper.cpp/blob/master/models/README.md
echo -e "${BLUE}Select model size:${NC}"
echo "1) Base (fastest, least accurate)"
echo "2) Medium (balanced)"
echo "3) Large (slowest, most accurate)"
read -p "Enter your choice (1-3): " model_choice

case $model_choice in
    1) model_size="base";;
    2) model_size="medium";;
    3) model_size="large";;
    *) echo -e "${RED}Invalid choice. Using base model.${NC}"; model_size="base";;
esac

echo -e "${YELLOW}Downloading ${model_size} model...${NC}"
./models/download-ggml-model.sh ${model_size}.en

echo -e "${BLUE}Detecting shell...${NC}"
if [ -f "$HOME/.zshrc" ]; then
    shell_rc="$HOME/.zshrc"
    echo -e "${GREEN}Found Zsh${NC}"
elif [ -f "$HOME/.bashrc" ]; then
    shell_rc="$HOME/.bashrc"
    echo -e "${GREEN}Found Bash${NC}"
else
    echo -e "${RED}No supported shell configuration found${NC}"
    exit 1
fi

echo -e "${YELLOW}Adding whisperclip function to ${shell_rc}...${NC}"
create_whisper_function "$shell_rc" "$model_size"

echo -e "${GREEN}✅ Setup complete!${NC}"
echo -e "${BLUE}Please restart your terminal or run: source ${shell_rc}${NC}"
