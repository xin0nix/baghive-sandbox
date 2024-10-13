cmake_minimum_required(VERSION 3.10)

project(BookingServiceProject)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

include(FetchContent)

find_package(Boost 1.83 REQUIRED)
find_package(GTest 1.14 REQUIRED)
find_package(OpenSSL REQUIRED)

# SOCI - C++ ORM
FetchContent_Declare(
    Soci
    GIT_REPOSITORY https://github.com/SOCI/soci.git
    GIT_TAG        v4.0.3
)
FetchContent_MakeAvailable(Soci)

# Pulsar - C++ Message Broker Client
FetchContent_Declare(
    Pulsar
    GIT_REPOSITORY https://github.com/apache/pulsar-client-cpp.git
    GIT_TAG        v3.6.0
)
FetchContent_MakeAvailable(Pulsar)

add_executable(BookingService src/main.cpp)

target_include_directories(BookingService PRIVATE
    "${CMAKE_CURRENT_BINARY_DIR}/_deps/pulsar-src/include/"
    "${CMAKE_CURRENT_BINARY_DIR}/_deps/soci-build/include"
    "${CMAKE_CURRENT_BINARY_DIR}/_deps/soci-src/include/"
)

target_link_directories(BookingService PRIVATE
    "${CMAKE_CURRENT_BINARY_DIR}/_deps/pulsar-build/lib/"
    "${CMAKE_CURRENT_BINARY_DIR}/lib/"
)

target_link_libraries(BookingService PRIVATE
    OpenSSL::SSL
    OpenSSL::Crypto
)