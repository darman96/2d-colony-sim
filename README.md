# 2d-colony-sim

## Building the Project

To build the project, follow these steps:

1. Ensure you have CMake installed on your system. You can download it from [https://cmake.org/download/](https://cmake.org/download/).
2. Clone the repository to your local machine using the following command:
   ```
   git clone https://github.com/darman96/2d-colony-sim.git
   ```
3. Navigate to the project directory:
   ```
   cd 2d-colony-sim
   ```
4. Create a build directory and navigate to it:
   ```
   mkdir build
   cd build
   ```
5. Run CMake to generate the build files:
   ```
   cmake ..
   ```
6. Build the project using the generated build files:
   ```
   cmake --build .
   ```

## Installing Dependencies

To install the required dependencies for Vulkan, GLFW, and GLM, follow these steps:

1. Install the Vulkan SDK:
   - Download the Vulkan SDK from the official Vulkan website: [https://vulkan.lunarg.com/sdk/home](https://vulkan.lunarg.com/sdk/home)
   - Follow the installation instructions for your operating system.

2. Install GLFW:
   - Download GLFW from the official GLFW website: [https://www.glfw.org/download.html](https://www.glfw.org/download.html)
   - Follow the installation instructions for your operating system.

3. Install GLM:
   - Download GLM from the official GLM GitHub repository: [https://github.com/g-truc/glm](https://github.com/g-truc/glm)
   - Follow the installation instructions for your operating system.

## Setting up the Vulkan SDK

To set up the Vulkan SDK, run the following command:
```
./setup_vulkan_sdk.sh
```

## Running the Project

To run the project, follow these steps:

1. After building the project, navigate to the build directory if you are not already there:
   ```
   cd build
   ```
2. Run the executable:
   ```
   ./2d-colony-sim
   ```
