FROM ubuntu:22.04 AS base
RUN apt-get update
RUN apt-get -y install wget build-essential cmake git

FROM base AS clang_setup
RUN  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get -y update
RUN apt-get -y install libllvm-17-ocaml-dev libllvm17 llvm-17 llvm-17-dev llvm-17-doc llvm-17-examples llvm-17-runtime
RUN apt-get -y install clang-17 clang-tools-17 clang-17-doc libclang-common-17-dev libclang-17-dev libclang1-17 clang-format-17 python3-clang-17 clangd-17 clang-tidy-17
RUN apt-get -y install libc++-17-dev libc++abi-17-dev
RUN apt-get -y install libomp-17-dev

FROM clang_setup AS vcpkg_setup
RUN git clone https://github.com/Microsoft/vcpkg.git /vcpkg
RUN /vcpkg/bootstrap-vcpkg.sh
ENV VCPKG_INSTALLATION_ROOT=/vcpkg
