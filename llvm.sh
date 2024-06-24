#!/usr/bin/env bash

set -euo pipefail

microdnf upgrade

microdnf install --enablerepo=devel \
  cmake \
  gcc-c++ \
  gzip \
  jq \
  libffi-devel \
  libxml2-devel \
  libzstd-devel \
  ncurses-devel \
  ninja-build \
  python3 \
  tar \
  zlib-devel

microdnf clean all

git_ref=$(curl -L https://api.github.com/repos/llvm/llvm-project/releases/latest | jq -r .tag_name)

pushd "$(mktemp -d)"

curl -L https://github.com/llvm/llvm-project/archive/refs/tags/$git_ref.tar.gz | tar xz --strip-components=1

cmake \
  -B build \
  -DBOOTSTRAP_CMAKE_INSTALL_PREFIX=/usr/local \
  -DBOOTSTRAP_LLVM_ENABLE_EH=ON \
  -DBOOTSTRAP_LLVM_ENABLE_FFI=ON \
  -DBOOTSTRAP_LLVM_ENABLE_LIBXML2=ON \
  -DBOOTSTRAP_LLVM_ENABLE_LLD=ON \
  -DBOOTSTRAP_LLVM_ENABLE_LTO=Thin \
  -DBOOTSTRAP_LLVM_ENABLE_PLUGINS=ON \
  -DBOOTSTRAP_LLVM_ENABLE_RTTI=ON \
  -DBOOTSTRAP_LLVM_ENABLE_TERMINFO=ON \
  -DBOOTSTRAP_LLVM_ENABLE_ZLIB=ON \
  -DBOOTSTRAP_LLVM_ENABLE_ZSTD=ON \
  -DBOOTSTRAP_LLVM_INSTALL_TOOLCHAIN_ONLY=ON \
  -DBOOTSTRAP_LLVM_LINK_LLVM_DYLIB=ON \
  -DBOOTSTRAP_LLVM_PARALLEL_LINK_JOBS=1 \
  -DCLANG_ENABLE_BOOTSTRAP=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_FLAGS="-march=native" \
  -DCMAKE_CXX_FLAGS="-march=native" \
  -DLLVM_ENABLE_PIC=OFF \
  -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb" \
  -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
  -DLLVM_INCLUDE_BENCHMARKS=OFF \
  -DLLVM_INCLUDE_EXAMPLES=OFF \
  -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_TARGETS_TO_BUILD=Native \
  -G Ninja \
  llvm

cmake --build build --target stage2-install

popd

rm -rf \
  /tmp/* \
  /var/cache/* \
  /var/lib/dnf \
  /var/log/* \
  /var/tmp/*
