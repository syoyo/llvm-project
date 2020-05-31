
BUILD_DIR=build

curdir=`pwd`

rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}
cd ${BUILD_DIR}

cmake -G Ninja \
  -DCMAKE_INSTALL_PREFIX=${curdir}/dist-host \
  -DCMAKE_BUILD_TYPE="MinSizeRel" \
  -DLLVM_TARGETS_TO_BUILD=host \
  -DLLVM_ENABLE_PROJECTS="clang" \
  -DLLVM_OPTIMIZED_TABLEGEN=On \
  ../llvm/
