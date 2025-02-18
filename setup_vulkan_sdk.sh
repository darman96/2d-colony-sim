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

# Create a temporary directory for downloading the Vulkan SDK
TEMP_DIR=$(mktemp -d)
if [ ! -d "$TEMP_DIR" ]; then
    echo "Failed to create temporary directory"
    exit 1
fi

# Download the Vulkan SDK binaries
echo "Downloading Vulkan SDK..."
wget -qO- https://sdk.lunarg.com/sdk/download/1.4.304.1/linux/vulkansdk-linux-x86_64-1.4.304.1.tar.xz | tar xJ -C "$TEMP_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to download or extract Vulkan SDK"
    exit 1
fi

# Copy the extracted SDK to /opt
echo "Copying Vulkan SDK to /opt..."
sudo cp -r "$TEMP_DIR/vulkansdk-linux-x86_64-1.4.304.1" /opt/vulkan-sdk
if [ $? -ne 0 ]; then
    echo "Failed to copy Vulkan SDK to /opt"
    exit 1
fi

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

# Set up environment variables
echo "Setting up environment variables..."
export VULKAN_SDK=/opt/vulkan-sdk
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
