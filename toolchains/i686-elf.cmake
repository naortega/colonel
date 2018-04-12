set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i686)

set(CMAKE_C_COMPILER i686-elf-gcc)
set(CMAKE_C_FLAGS "-ffreestanding -fno-builtin" CACHE STRING "C flags for test compilation.")
set(CMAKE_EXE_LINKER_FLAGS "-ffreestanding -nostdlib" CACHE STRING "Linker flags for test compilation.")
set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES CMAKE_C_FLAGS)
set(CMAKE_ASM_COMPILER i686-elf-as)

set(64BIT FALSE CACHE BOOL "Whether the architecture supports 64-bit.")
