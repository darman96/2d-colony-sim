#include <iostream>
#include <chrono>
#include <thread>
#include <atomic>

std::atomic<bool> isRunning(true);

void handleInput() {
    while (isRunning) {
        char input;
        std::cin >> input;
        if (input == 'q') {
            isRunning = false;
        }
    }
}

int main() {
    auto lastTime = std::chrono::high_resolution_clock::now();
    int frameCount = 0;
    auto startTime = lastTime;

    std::thread inputThread(handleInput);

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

        // Sleep to limit frame rate
        std::this_thread::sleep_for(std::chrono::milliseconds(16));
    }

    inputThread.join();

    return 0;
}
