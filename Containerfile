FROM registry.access.redhat.com/ubi8/ubi-minimal

COPY llvm.sh /tmp

RUN /tmp/llvm.sh
