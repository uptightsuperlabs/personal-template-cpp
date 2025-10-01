#include <windows.h>
#include <iostream>
#include <thread>

bool is_running = false;

void cheat_attach_thread(HINSTANCE instance) {
    std::cout << "attached @ 0x" << std::hex << &instance << std::endl;
}

BOOL APIENTRY DllMain(HINSTANCE instance, DWORD reason, LPVOID reserved) {
    if (DLL_PROCESS_ATTACH && !is_running) {
        std::thread(cheat_attach_thread, instance).detach();
        is_running = true;
    }

    return TRUE;
}