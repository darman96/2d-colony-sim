#!/bin/bash

# Check if Vulkan SDK is already installed
if [ -d "$VULKAN_SDK" ]; then
    echo "Vulkan SDK is already installed at $VULKAN_SDK"
    exit 0
fi

# Download and install Vulkan SDK
echo "Downloading Vulkan SDK..."
wget -qO- https://sdk.lunarg.com/sdk/download/latest/linux/vulkan-sdk.tar.gz | tar xz -C /opt

# Set up environment variables
echo "Setting up environment variables..."
export VULKAN_SDK=/opt/vulkan-sdk/x.x.x.x/x86_64
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
