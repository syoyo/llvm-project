# Build llvm-tblgen on host before

ANDROID_NDK_ROOT=$HOME/Android/Sdk/ndk/21.0.6113669

BUILD_DIR=build-android

curdir=`pwd`

rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}
cd ${BUILD_DIR}

# Edit path to tblgen if required
#cmake -G Ninja \
#  -DCMAKE_INSTALL_PREFIX=${curdir}/dist \
#  -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_ROOT/build/cmake/android.toolchain.cmake \
#  -DLLVM_TABLEGEN=$HOME/local/clang+llvm-9.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/llvm-tblgen \
#  -DANDROID_ABI=arm64-v8a \
#  -DANDROID_NATIVE_API_LEVEL=28 \
#  -DLLVM_DEFAULT_TARGET_TRIPLE=aarch64-linux-android \
#  -DLLVM_TARGET_ARCH=ARM \
#  -DLLVM_TARGETS_TO_BUILD=ARM \ 
#  ../llvm/

cmake -G Ninja \
  -DCMAKE_INSTALL_PREFIX=${curdir}/dist \
  -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_ROOT/build/cmake/android.toolchain.cmake \
  -DLLVM_TABLEGEN=${curdir}/dist-host/bin/llvm-tblgen \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_NATIVE_API_LEVEL=28 \
  -DLLVM_ENABLE_UNWIND_TABLES=Off \
  -DLLVM_BUILD_TOOLS=Off \
  -DLLVM_BUILD_LLVM_DYLIB="On" \
  -DLLVM_TARGET_ARCH=AArch64 \
  -DLLVM_TARGETS_TO_BUILD=AArch64 \
  ../llvm/
