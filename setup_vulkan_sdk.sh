#!/bin/bash

# Check if Vulkan SDK is already installed
if [ -d "$VULKAN_SDK" ]; then
    echo "Vulkan SDK is already installed at $VULKAN_SDK"
    exit 0
fi

# Prompt the user for sudo password when necessary
if [ "$EUID" -ne 0 ]; then
    echo "This script requires sudo privileges. Please enter your password."
    sudo -v
fi

# Clone the Vulkan SDK repository
echo "Cloning Vulkan SDK repository..."
sudo git clone --recursive https://github.com/KhronosGroup/Vulkan-Loader.git /opt/vulkan-sdk
if [ $? -ne 0 ]; then
    echo "Failed to clone Vulkan SDK repository"
    exit 1
fi

# Build the Vulkan SDK
echo "Building Vulkan SDK..."
cd /opt/vulkan-sdk
mkdir build
cd build
cmake ..
make
if [ $? -ne 0 ]; then
    echo "Failed to build Vulkan SDK"
    exit 1
fi

# Set up environment variables
echo "Setting up environment variables..."
export VULKAN_SDK=/opt/vulkan-sdk/build
export PATH=$VULKAN_SDK/bin:$PATH
export LD_LIBRARY_PATH=$VULKAN_SDK/lib:$LD_LIBRARY_PATH
export VK_ICD_FILENAMES=$VULKAN_SDK/etc/vulkan/icd.d/nvidia_icd.json
export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d

# Add environment variables to .bashrc
echo "Adding environment variables to .bashrc..."
echo "export VULKAN_SDK=$VULKAN_SDK" >> ~/.bashrc
echo "export PATH=\$VULKAN_SDK/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$VULKAN_SDK/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export VK_ICD_FILENAMES=\$VULKAN_SDK/etc/vulkan/icd.d/nvidia_icd.json" >> ~/.bashrc
echo "export VK_LAYER_PATH=\$VULKAN_SDK/etc/vulkan/explicit_layer.d" >> ~/.bashrc

# Add environment variables to .zshrc
echo "Adding environment variables to .zshrc..."
echo "export VULKAN_SDK=$VULKAN_SDK" >> ~/.zshrc
echo "export PATH=\$VULKAN_SDK/bin:\$PATH" >> ~/.zshrc
echo "export LD_LIBRARY_PATH=\$VULKAN_SDK/lib:\$LD_LIBRARY_PATH" >> ~/.zshrc
echo "export VK_ICD_FILENAMES=\$VULKAN_SDK/etc/vulkan/icd.d/nvidia_icd.json" >> ~/.zshrc
echo "export VK_LAYER_PATH=\$VULKAN_SDK/etc/vulkan/explicit_layer.d" >> ~/.zshrc

echo "Vulkan SDK setup complete. Please restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc' to apply the changes."
