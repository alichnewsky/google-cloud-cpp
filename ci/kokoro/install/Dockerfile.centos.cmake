# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG DISTRO_VERSION=7
FROM centos:${DISTRO_VERSION} AS devtools
ARG NCPU=4

# Please keep the formatting in these commands, it is optimized to cut & paste
# into the README.md file.

## [START INSTALL.md]

# First install the development tools and OpenSSL. The development tools
# distributed with CentOS (notably CMake) are too old to build
# `google-cloud-cpp`. In these instructions, we use `cmake3` obtained from
# [Software Collections](https://www.softwarecollections.org/).

# ```bash
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y centos-release-scl
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms
RUN yum makecache && \
    yum install -y automake curl-devel gcc gcc-c++ git libtool \
        make openssl-devel pkgconfig tar wget which zlib-devel
# this seems to be posing problem .... cmake3	
# this also has problem : no https support in the libcurl linked in it !!?
#RUN yum install -y llvm-toolset-7-cmake
#RUN ln -sf /opt/rh/llvm-toolset-7/root/bin/cmake3  /usr/bin/cmake && \
#    ln -sf /opt/rh/llvm-toolset-7/root/bin/ccmake3 /usr/bin/ccmake && \
#    ln -sf /opt/rh/llvm-toolset-7/root/bin/ctest3  /usr/bin/ctest


# build CMake from scratch

# CMake 
# ```
WORKDIR /var/tmp/build
RUN wget -q https://gitlab.kitware.com/cmake/cmake/-/archive/v3.15.2/cmake-v3.15.2.tar.gz
RUN tar -xf cmake-v3.15.2.tar.gz
WORKDIR /var/tmp/build/cmake-v3.15.2
# the question here is ./bootstrap or ./bootstrap --system-curl ...
RUN ./bootstrap && make -j ${NCPU:-4} && make install
RUN ln -s /usr/local/bin/cmake /usr/bin/cmake && \
    ln -s /usr/local/bin/ctest /usr/bin/ctest

# ```

# #### crc32c

# There is no CentOS package for this library. To install it use:

# ```bash
WORKDIR /var/tmp/build
RUN wget -q https://github.com/google/crc32c/archive/1.0.6.tar.gz
RUN tar -xf 1.0.6.tar.gz
WORKDIR /var/tmp/build/crc32c-1.0.6
RUN cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=yes \
      -DCRC32C_BUILD_TESTS=OFF \
      -DCRC32C_BUILD_BENCHMARKS=OFF \
      -DCRC32C_USE_GLOG=OFF \
      -H. -Bcmake-out/crc32c
RUN cmake --build cmake-out/crc32c --target install -- -j ${NCPU:-4}
# centos does not have this
# as a result protoc, grpc code generators don't run...
# otherwise you need ENV LD_LIBRARY_PATH set... at build only...
RUN echo /usr/local/lib64 > /etc/ld.so.conf.d/local.conf
RUN ldconfig
# ```

# #### Protobuf

# Likewise, manually install protobuf:

# ```bash
WORKDIR /var/tmp/build
RUN wget -q https://github.com/google/protobuf/archive/v3.6.1.tar.gz
RUN tar -xf v3.6.1.tar.gz
WORKDIR /var/tmp/build/protobuf-3.6.1/cmake
RUN cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=yes \
        -Dprotobuf_BUILD_TESTS=OFF \
        -H. -Bcmake-out
RUN cmake --build cmake-out --target install -- -j ${NCPU:-4}
RUN ldconfig
# ```

# #### c-ares

# Recent versions of gRPC require c-ares >= 1.11, while CentOS-7
# distributes c-ares-1.10. Manually install a newer version:

# ```bash
WORKDIR /var/tmp/build
RUN wget -q https://github.com/c-ares/c-ares/archive/cares-1_14_0.tar.gz
RUN tar -xf cares-1_14_0.tar.gz
WORKDIR /var/tmp/build/c-ares-cares-1_14_0
# this does not install c-ares as a CMake package
#
#RUN ./buildconf && ./configure && make -j ${NCPU:-4}
#RUN make install
# installs in /usr/local/lib : not in /etc/ld.so.conf.d/local.conf
RUN cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=yes \
    -H. -Bcmake-out
RUN cmake --build cmake-out    --target install -- -j ${NCPU:-4}
RUN ldconfig
# ```

# #### NGHTTP2

# not mandatory
# this build nghttp2 without libev or asynchronous io...

# ```
WORKDIR /var/tmp/build
RUN wget -q https://github.com/nghttp2/nghttp2/releases/download/v1.39.1/nghttp2-1.39.1.tar.gz
RUN tar -xf nghttp2-1.39.1.tar.gz
WORKDIR /var/tmp/build/nghttp2-1.39.1
RUN cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=yes \
	-DENABLE_ARES=ON \
        -H. -Bcmake-out
RUN cmake --build cmake-out --target install -- -j ${NCPU:-4}
RUN ldconfig

# #### libcURL

# keep control on the version of libcurl used both for gRPC and HTTP calls
# right now, that does not do HTTP/2 for example
# ```bash
WORKDIR /var/tmp/build
# verify sha-256
RUN wget -q https://curl.haxx.se/download/curl-7.60.0.tar.gz
RUN tar -xf curl-7.60.0.tar.gz

WORKDIR /var/tmp/build/curl-7.60.0
# if you pass -DHTTP_ONLY=ON then it disables all other protocols including HTTPS ...
# don't do this.
# I have added HTTP/2 for the kick of it here.
# 
# need also to set the default CA locations or
# CURL_WANTS_CA_BUNDLE_ENV to replace the default value with getenv("CURL_CA_BUNDLE")
# you can inspect the locations with 
# /usr/bin/curl-config --ca
#
RUN cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=yes \
	-DENABLE_ARES=ON \
	-DUSE_NGHTTP2=OFF \
	-DCMAKE_ENABLE_OPENSSL=ON \
        -H. -Bcmake-out
RUN cmake --build cmake-out --target install -- -j ${NCPU:-4}
RUN ldconfig
#```

# #### gRPC

# Can be manually installed using:

# ```bash
WORKDIR /var/tmp/build
RUN wget -q https://github.com/grpc/grpc/archive/v1.19.1.tar.gz
RUN tar -xf v1.19.1.tar.gz
WORKDIR /var/tmp/build/grpc-1.19.1
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64
ENV PATH=/usr/local/bin:${PATH}
# this does not install gRPC as a CMake package...
#
#RUN make -j ${NCPU:-4}
#RUN make install
RUN cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=yes \
        -DgRPC_BUILD_TESTS=OFF \
        -DgRPC_ZLIB_PROVIDER=package \
        -DgRPC_SSL_PROVIDER=package \
        -DgRPC_CARES_PROVIDER=package \
        -DgRPC_PROTOBUF_PROVIDER=package \
	-H. -Bcmake-out
RUN cmake --build cmake-out --target install -- -j ${NCPU:-4}
RUN ldconfig
RUN ldconfig

# ```

# #### googleapis

# There is no CentOS package for this library. To install it, use:

# ```bash
WORKDIR /var/tmp/build

# modified version with more libraries pre-built
RUN wget -q https://github.com/alichnewsky/cpp-cmakefiles/tarball/b2046635c11c043795fba24a47db3c3ea90de6cd
# expect SHA 256 hash 5ef3f772e8d8d584bddb2f81104ade509502c5eb23fc98ab03eff63a8bb450dd
RUN tar -xf b2046635c11c043795fba24a47db3c3ea90de6cd
WORKDIR /var/tmp/build/alichnewsky-cpp-cmakefiles-b204663

#RUN wget -q https://github.com/googleapis/cpp-cmakefiles/archive/v0.1.1.tar.gz
#RUN tar -xf v0.1.1.tar.gz
#WORKDIR /var/tmp/build/cpp-cmakefiles-0.1.1

RUN cmake \
    -DBUILD_SHARED_LIBS=YES \
    -H. -Bcmake-out
RUN cmake --build cmake-out --target install -- -j ${NCPU:-4}
RUN ldconfig
# ```

FROM devtools AS install

# #### google-cloud-cpp

# Finally we can install `google-cloud-cpp`.

# ```bash
WORKDIR /var/tmp/build/google-cloud-cpp
COPY . /var/tmp/build/google-cloud-cpp
RUN cmake -H. -Bcmake-out \
    -DGOOGLE_CLOUD_CPP_DEPENDENCY_PROVIDER=package \
    -DGOOGLE_CLOUD_CPP_GMOCK_PROVIDER=external \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
RUN cmake --build cmake-out -- -j ${NCPU:-4}
RUN cmake -H. -Bcmake-out \
    -DGOOGLE_CLOUD_CPP_DEPENDENCY_PROVIDER=package \
    -DGOOGLE_CLOUD_CPP_GMOCK_PROVIDER=external \
    -DBUILD_SHARED_LIBS=YES
RUN cmake --build cmake-out -- -j ${NCPU:-4}
WORKDIR /var/tmp/build/google-cloud-cpp/cmake-out
RUN ctest --output-on-failure
RUN cmake --build . --target install
# ```

## [END INSTALL.md]

#
# The plain make install does not work because the gRPC install
# Does not install gRPC's pkg-config files...
#

# Verify that the installed files are actually usable
#WORKDIR /home/build/test-install-plain-make
#COPY ci/test-install /home/build/test-install-plain-make
#RUN make

WORKDIR /home/build/test-install-cmake-bigtable
COPY ci/test-install/bigtable /home/build/test-install-cmake-bigtable
RUN env -u PKG_CONFIG_PATH cmake -H. -Bcmake-out
RUN cmake --build cmake-out -- -j ${NCPU:-4}

WORKDIR /home/build/test-install-cmake-storage
COPY ci/test-install/storage /home/build/test-install-cmake-storage
RUN env -u PKG_CONFIG_PATH cmake -H. -Bcmake-out
RUN cmake --build cmake-out -- -j ${NCPU:-4}

WORKDIR /home/build/test-submodule
COPY ci/test-install /home/build/test-submodule
COPY . /home/build/test-submodule/submodule/google-cloud-cpp
# lets not rebuild from scratch if using packages
#RUN cmake -Hsubmodule -Bcmake-out
RUN cmake -Hsubmodule -Bcmake-out \
    -DGOOGLE_CLOUD_CPP_DEPENDENCY_PROVIDER=package \
    -DGOOGLE_CLOUD_CPP_GMOCK_PROVIDER=external \
    -DBUILD_SHARED_LIBS=YES
RUN cmake --build cmake-out -- -j ${NCPU:-4}
