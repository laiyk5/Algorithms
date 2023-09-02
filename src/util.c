#include "util.h"
#include "stdio.h"

void printErr(const char* message) {
    fputs(message, stderr);
}