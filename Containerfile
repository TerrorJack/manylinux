FROM rockylinux:8-minimal

COPY llvm.sh /tmp

RUN /tmp/llvm.sh
