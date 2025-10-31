#include <windows.h>

BOOL APIENTRY DllMain(HINSTANCE instance, DWORD reason, LPVOID reserved) {
    return TRUE;
}

/*

// uptightsuperlabs - 10/31/2025 just encase i need to do shi for linux i can just delete above and the comment blocks lol.

__attribute__((constructor)) void init() {
    ;
}

__attribute__((destructor)) void dinit() {
    ;
}

*/