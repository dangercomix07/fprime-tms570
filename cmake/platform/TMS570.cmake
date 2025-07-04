####
# platform.cmake.template:
#
# This file acts as a template for the fprime platform files used by the CMake system.
# These files specify build flags, compiler directives, and must specify an include
# directory for system includes like "PlatformTypes.hpp".
#
# Follow all the steps in this template to create a platform file. Ensure
# to remove the platform-failsafe (step 1) and fill in all <SOMETHING> tags.
#
# **Note:** If the user desires to set compiler paths, and other CMake toolchain settings, a
#           toolchain file should be constructed. See: toolchain.md
#
# ### Platform File Loading ###
#
# The user rarely needs to specify a platform file directly. It will be specified based on the data
# in the chosen Toolchain file, or by the CMake system itself. However, if the user wants to control
# which platform file is used, the load is specified by the following rules:
#
# If the user specifies a CMake Toolchain file, then the platform file `${CMAKE_SYSTEM_NAME}.cmake`
# will be used. `${CMAKE_SYSTEM_NAME}` is set in the toolchain file and is typically set to a name like Linux, or Darwin
# but may be more specific if required.
#
# Otherwise, CMake sets the `${CMAKE_SYSTEM_NAME}` automatically to be that of the Host system, and that platform
# will be used. e.g. when building on Linux, the platform file "Linux.cmake" will be used.
#
# ### Filling In CMake Platform by Example ###
#
# F prime platform files are used to set F prime specific settings. This allows the user to control
# some aspects of the F prime build at the top-level. This means setting global include directories
# compiler definitions for the platform, threading libraries, etc. The bare-minimum platform file
# should specify an include directory for "PlatformTypes.hpp" and a threading library if using
# active components with OS supported threads. This can be done with the following lines:
#
# ```
# FIND_PACKAGE ( Threads REQUIRED )
# include_directories(SYSTEM "${FPRIME_FRAMEWORK_PATH}/Fw/Types/Linux")
# ```
#
# **Note:** much of this is done already in *-common.cmake for Linux. If using a linux-like system,
#           this can be included to save time.
#
# **Note:** if copying the template, delete the message with FATAL_ERROR line. This is a fail-safe
#           to prevent a raw-copy from being treated as a valid toolchain file.
####

## STEP 2: Specify the OS type include directive i.e. LINUX or DARWIN
add_definitions(-DTGT_OS_TYPE_TMS570)

# STEP 3: Specify CMAKE C and CXX compile flags. DO NOT clear existing flags
set(CMAKE_C_FLAGS
  "${CMAKE_C_FLAGS} -mv7R5 --code_state=32 --float_support=VFPv3D16 --enum_type=packed --abi=eabi -g --diag_warning=225 --diag_wrap=off --display_error_number"
)
set(CMAKE_CXX_FLAGS
  "${CMAKE_CXX_FLAGS} -mv7R5 --code_state=32 --float_support=VFPv3D16 --enum_type=packed --abi=eabi -g --diag_warning=225 --diag_wrap=off --display_error_number"
)

## STEP 4: Specify that a thread package should be searched in the toolchain
# But for your baremetal TMS570, you DON'T want to enable POSIX threads.
set(FPRIME_USE_BAREMETAL_SCHEDULER ON)

# STEP 5: Specify a directory containing the "PlatformTypes.hpp" headers, as well
#         as other system headers. Other global headers can be placed here.
#         Note: Typically, the Linux directory is a good default, as it grabs
#         standard types from <cstdint>.
## STEP 5: Specify a directory containing the "PlatformTypes.hpp" headers
# We'll create a custom version later — use a dummy fallback for now to allow config
include_directories(SYSTEM "${CMAKE_CURRENT_LIST_DIR}/types")
add_definitions(-DPLATFORM_OVERRIDE_GCC_CLANG_CHECK)

# HALCoGen HAL Support: Include HAL paths for compile
include_directories("${CMAKE_SOURCE_DIR}/lib/tms570-hal/include")
include_directories("${CMAKE_SOURCE_DIR}/lib/tms570-hal/source")

# Glob HAL Sources
file(GLOB HAL_SOURCES
    "${CMAKE_SOURCE_DIR}/lib/tms570-hal/source/*.c"
    "${CMAKE_SOURCE_DIR}/lib/tms570-hal/source/*.asm"
)

# Add to global source list
set(FPRIME_ADDITIONAL_SOURCES ${HAL_SOURCES})

# Linker script
set(FPRIME_LINKER_SCRIPT "${CMAKE_SOURCE_DIR}/lib/tms570-hal/source/HL_sys_link.cmd")

# Print for debug
message(STATUS "[Platform:TMS570LC43] Using HAL sources from lib/tms570-hal")
message(STATUS "[Platform:TMS570LC43] Linker script: ${FPRIME_LINKER_SCRIPT}")
