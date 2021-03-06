//===-- Implementation of llrintl function --------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/__support/common.h"
#include "utils/FPUtil/NearestIntegerOperations.h"

namespace __llvm_libc {

long long LLVM_LIBC_ENTRYPOINT(llrintl)(long double x) {
  return fputil::roundToSignedIntegerUsingCurrentRoundingMode<long double,
                                                              long long>(x);
}

} // namespace __llvm_libc
