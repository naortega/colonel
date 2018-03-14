# Copyright (C) 2018  Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
# Author: Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cmake_minimum_required(VERSION 2.8)
project(colonel C ASM)

set(TARGET_NAME "colonel.bin")

if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "release")
endif()

string(TOLOWER ${CMAKE_BUILD_TYPE} CMAKE_BUILD_TYPE)
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# flags
set(CMAKE_C_FLAGS "-std=c99 -ffreestanding -fno-builtin -Wall -Wextra")
set(CMAKE_C_FLAGS_DEBUG "-g -O0")
set(CMAKE_C_FLAGS_RELEASE "-O3")
set(CMAKE_ASM_FLAGS "")
set(CMAKE_ASM_FLAGS_RELEASE "")

include_directories(
	"src/")

# source files
set(SRCS
	src/kernel/kernel.c)

# architecture specific code
if(${CMAKE_SYSTEM_PROCESSOR} MATCHES "i.86")
	set(SRCS
		src/kernel/arch/x86/boot.s
		${SRCS}
		src/kernel/arch/x86/tty.c)
	set_source_files_properties(
		src/kernel/arch/x86/boot.s
		PROPERTIES COMPILE_FLAGS ""
		)
	set(CMAKE_EXE_LINKER_FLAGS
		"-T ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel/arch/x86/linker.ld -ffreestanding -nostdlib")
	include_directories(
		"src/kernel/arch/x86/")
endif()

add_executable(${TARGET_NAME} ${SRCS})
