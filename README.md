# manylinux

Nothing to see here, just a container image based on [Red Hat
Universal Base Image
8](https://catalog.redhat.com/software/container-stacks/detail/5ec53f50ef29fd35586d9a56),
with latest `clang` installed in `/usr/local/bin`. Useful for building
Linux executables that link against a reasonably old glibc (`2.28`) to
improve portability across distros, without losing benefits of using a
cutting-edge C/C++ toolchain to improve code generation.
