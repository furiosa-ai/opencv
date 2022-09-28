#!/bin/sh
# Show logs
set -x
# Exit on error
set -e

# Compile cmake
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D WIDTH_TBB=OFF \
    -D WITH_V4L=OFF \
    -D WITH_FFMPEG=OFF \
    -D BUILD_opencv_cudacodec=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D WITH_1394=OFF \
    -D WITH_LIBV4L=OFF \
    -D WITH_QT=OFF \
    -D WITH_OPENGL=OFF \
    -D ENABLE_FAST_MATH=1 \
    -D CMAKE_CXX_STANDARD=14 \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
     . -B opencv_build

cd opencv_build

# https://blog.katastros.com/a?ID=00900-2f0fc7b6-ca31-44ec-923b-f7df72c7da5d, chamfermatching.cpp compiling problem
sed -i 's/-Werror=address//' modules/contrib/CMakeFiles/opencv_contrib.dir/flags.make

# Compile
make -j $(nproc)
