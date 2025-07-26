#!/bin/bash
set -e  # Exit on error

# 1. Goto user home
cd ~/

# 2. Download and unzip
wget https://github.com/xinntao/Real-ESRGAN/archive/refs/tags/v0.3.0.zip
unzip v0.3.0.zip
rm v0.3.0.zip
cd Real-ESRGAN-0.3.0

# 3. Setup venv
python3 -m venv venv
source venv/bin/activate

# 4. Install dependencies
pip install --upgrade pip
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install basicsr facexlib gfpgan
pip install -r requirements.txt
pip install -e .

# 5. Fix import error in degradations.py
# Find degradations.py and patch the import line if needed
DEGRADATIONS_FILE=$(find . -type f -name degradations.py | head -n 1)

if [[ -f "$DEGRADATIONS_FILE" ]]; then
  if grep -q "from torchvision.transforms.functional_tensor import rgb_to_grayscale" "$DEGRADATIONS_FILE"; then
    sed -i 's/from torchvision.transforms.functional_tensor import rgb_to_grayscale/from torchvision.transforms._functional_tensor import rgb_to_grayscale/' "$DEGRADATIONS_FILE"
    echo "Patched: $DEGRADATIONS_FILE"
  else
    echo "Patch not needed: already fixed or using compatible torchvision version."
  fi
else
  echo "Could not find degradations.py"
fi

# 6. Download models
mkdir -p weights
wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P weights
wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth -P weights

# 7. Run inference example
echo -e "\nSuccessfully installed Real-ESRGAN v0.3.0\n"
echo -e "To activate the environment and run Real-ESRGAN:\n"
echo -e "  cd ~/Real-ESRGAN-0.3.0"
echo -e "  source venv/bin/activate\n"
echo -e "Place your input images in the 'inputs/' directory\n"
echo -e "Example usage with standard model:"
echo -e "  python inference_realesrgan.py -n RealESRGAN_x4plus\n"
echo -e "Example usage with anime model:"
echo -e "  python inference_realesrgan.py -n RealESRGAN_x4plus_anime_6B\n"
echo -e "Results will be saved to the 'results/' folder by default.\n"
