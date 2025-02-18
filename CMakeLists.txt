cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(2d-colony-sim VERSION 1.0)

# Find Vulkan
find_package(Vulkan REQUIRED)

# Find GLFW
find_package(GLFW3 REQUIRED)

# Find GLM
find_package(glm REQUIRED)

# add the executable
add_executable(2d-colony-sim src/main.cpp)

# Link Vulkan, GLFW, and GLM libraries to the executable
target_link_libraries(2d-colony-sim Vulkan::Vulkan GLFW::GLFW glm::glm)
