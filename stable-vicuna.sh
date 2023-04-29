#!/bin/bash

# Install transformers if not already installed
python -c "import transformers" 2> /dev/null || pip install --upgrade transformers

# Update package lists and install Git LFS if not already installed
which git-lfs > /dev/null || (sudo apt-get update && sudo apt-get install git-lfs)

# Clone necessary repositories
for repo in "https://huggingface.co/elinas/llama-13b-hf-transformers-4.29" "https://huggingface.co/CarperAI/stable-vicuna-13b-delta"; do
    dir=$(basename ${repo})
    [ -d "${dir}" ] || git clone ${repo}
done

# Apply delta weights if not already applied
[ -d "stable-vicuna-13b-applied" ] || python3 stable-vicuna-13b-delta/apply_delta.py --base llama-13b-hf-transformers-4.29 --target stable-vicuna-13b-applied --delta stable-vicuna-13b-delta
