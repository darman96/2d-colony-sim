#include <iostream>
#include <chrono>

int main() {
    bool isRunning = true;
    auto lastTime = std::chrono::high_resolution_clock::now();
    int frameCount = 0;
    auto startTime = lastTime;

    while (isRunning) {
        // Calculate delta time
        auto currentTime = std::chrono::high_resolution_clock::now();
        std::chrono::duration<float> deltaTime = currentTime - lastTime;
        lastTime = currentTime;

        // Update game state placeholder

        // Calculate FPS
        frameCount++;
        std::chrono::duration<float> elapsedTime = currentTime - startTime;
        if (elapsedTime.count() >= 1.0f) {
            float fps = frameCount / elapsedTime.count();
            std::cout << "FPS: " << fps << std::endl;
            frameCount = 0;
            startTime = currentTime;
        }

        // Placeholder for handling user input
        char input;
        std::cin >> input;
        if (input == 'q') {
            isRunning = false;
        }
    }

    return 0;
}
