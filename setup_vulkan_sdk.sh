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

# Create a temporary directory for building the Vulkan SDK
TEMP_DIR=$(mktemp -d)
if [ ! -d "$TEMP_DIR" ]; then
    echo "Failed to create temporary directory"
    exit 1
fi

# Clone the Vulkan SDK repository
echo "Cloning Vulkan SDK repository..."
git clone --recursive https://github.com/KhronosGroup/Vulkan-Loader.git "$TEMP_DIR/vulkan-sdk"
if [ $? -ne 0 ]; then
    echo "Failed to clone Vulkan SDK repository"
    exit 1
fi

# Build the Vulkan SDK
echo "Building Vulkan SDK..."
cd "$TEMP_DIR/vulkan-sdk"
mkdir build
cd build
cmake ..
make
if [ $? -ne 0 ]; then
    echo "Failed to build Vulkan SDK"
    exit 1
fi

# Copy the built SDK to /opt
echo "Copying Vulkan SDK to /opt..."
sudo cp -r "$TEMP_DIR/vulkan-sdk/build" /opt/vulkan-sdk
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
