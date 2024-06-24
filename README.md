# manylinux

Nothing to see here, just a container image based on [Rocky Linux
8](https://hub.docker.com/_/rockylinux), with latest `clang` installed
in `/usr/local/bin`. Useful for building Linux executables that link
against a reasonably old glibc (`2.28`) to improve portability across
distros, without losing benefits of using a cutting-edge C/C++
toolchain to improve code generation.
