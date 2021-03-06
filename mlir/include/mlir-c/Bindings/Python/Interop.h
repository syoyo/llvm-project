//===-- mlir-c/Interop.h - Constants for Python/C-API interop -----*- C -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM
// Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This header declares constants and helpers necessary for C-level
// interop with the MLIR Python extension module. Since the Python bindings
// are a thin wrapper around the MLIR C-API, a further C-API is not provided
// specifically for the Python extension. Instead, simple facilities are
// provided for translating between Python types and corresponding MLIR C-API
// types.
//
// This header is standalone, requiring nothing beyond normal linking against
// the Python implementation.
//===----------------------------------------------------------------------===//

#ifndef MLIR_C_BINDINGS_PYTHON_INTEROP_H
#define MLIR_C_BINDINGS_PYTHON_INTEROP_H

#include <Python.h>

#include "mlir-c/AffineMap.h"
#include "mlir-c/IR.h"
#include "mlir-c/Pass.h"

#define MLIR_PYTHON_CAPSULE_AFFINE_MAP "mlir.ir.AffineMap._CAPIPtr"
#define MLIR_PYTHON_CAPSULE_ATTRIBUTE "mlir.ir.Attribute._CAPIPtr"
#define MLIR_PYTHON_CAPSULE_CONTEXT "mlir.ir.Context._CAPIPtr"
#define MLIR_PYTHON_CAPSULE_LOCATION "mlir.ir.Location._CAPIPtr"
#define MLIR_PYTHON_CAPSULE_MODULE "mlir.ir.Module._CAPIPtr"
#define MLIR_PYTHON_CAPSULE_OPERATION "mlir.ir.Operation._CAPIPtr"
#define MLIR_PYTHON_CAPSULE_TYPE "mlir.ir.Type._CAPIPtr"
#define MLIR_PYTHON_CAPSULE_PASS_MANAGER "mlir.passmanager.PassManager._CAPIPtr"

/** Attribute on MLIR Python objects that expose their C-API pointer.
 * This will be a type-specific capsule created as per one of the helpers
 * below.
 *
 * Ownership is not transferred by acquiring a capsule in this way: the
 * validity of the pointer wrapped by the capsule will be bounded by the
 * lifetime of the Python object that produced it. Only the name and pointer
 * of the capsule are set. The caller is free to set a destructor and context
 * as needed to manage anything further. */
#define MLIR_PYTHON_CAPI_PTR_ATTR "_CAPIPtr"

/** Attribute on MLIR Python objects that exposes a factory function for
 * constructing the corresponding Python object from a type-specific
 * capsule wrapping the C-API pointer. The signature of the function is:
 *   def _CAPICreate(capsule) -> object
 * Calling such a function implies a transfer of ownership of the object the
 * capsule wraps: after such a call, the capsule should be considered invalid,
 * and its wrapped pointer must not be destroyed.
 *
 * Only a very small number of Python objects can be created in such a fashion
 * (i.e. top-level types such as Context where the lifetime can be cleanly
 * delineated). */
#define MLIR_PYTHON_CAPI_FACTORY_ATTR "_CAPICreate"

/// Gets a void* from a wrapped struct. Needed because const cast is different
/// between C/C++.
#ifdef __cplusplus
#define MLIR_PYTHON_GET_WRAPPED_POINTER(object) const_cast<void *>(object.ptr)
#else
#define MLIR_PYTHON_GET_WRAPPED_POINTER(object) (void *)(object.ptr)
#endif

#ifdef __cplusplus
extern "C" {
#endif

/** Creates a capsule object encapsulating the raw C-API MlirAttribute.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the attribute in any way.
 */
static inline PyObject *mlirPythonAttributeToCapsule(MlirAttribute attribute) {
  return PyCapsule_New(MLIR_PYTHON_GET_WRAPPED_POINTER(attribute),
                       MLIR_PYTHON_CAPSULE_ATTRIBUTE, NULL);
}

/** Extracts an MlirAttribute from a capsule as produced from
 * mlirPythonAttributeToCapsule. If the capsule is not of the right type, then
 * a null attribute is returned (as checked via mlirAttributeIsNull). In such a
 * case, the Python APIs will have already set an error. */
static inline MlirAttribute mlirPythonCapsuleToAttribute(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_ATTRIBUTE);
  MlirAttribute attr = {ptr};
  return attr;
}

/** Creates a capsule object encapsulating the raw C-API MlirContext.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the context in any way.
 */
static inline PyObject *mlirPythonContextToCapsule(MlirContext context) {
  return PyCapsule_New(context.ptr, MLIR_PYTHON_CAPSULE_CONTEXT, NULL);
}

/** Extracts a MlirContext from a capsule as produced from
 * mlirPythonContextToCapsule. If the capsule is not of the right type, then
 * a null context is returned (as checked via mlirContextIsNull). In such a
 * case, the Python APIs will have already set an error. */
static inline MlirContext mlirPythonCapsuleToContext(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_CONTEXT);
  MlirContext context = {ptr};
  return context;
}

/** Creates a capsule object encapsulating the raw C-API MlirLocation.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the location in any way. */
static inline PyObject *mlirPythonLocationToCapsule(MlirLocation loc) {
  return PyCapsule_New(MLIR_PYTHON_GET_WRAPPED_POINTER(loc),
                       MLIR_PYTHON_CAPSULE_LOCATION, NULL);
}

/** Extracts an MlirLocation from a capsule as produced from
 * mlirPythonLocationToCapsule. If the capsule is not of the right type, then
 * a null module is returned (as checked via mlirLocationIsNull). In such a
 * case, the Python APIs will have already set an error. */
static inline MlirLocation mlirPythonCapsuleToLocation(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_LOCATION);
  MlirLocation loc = {ptr};
  return loc;
}

/** Creates a capsule object encapsulating the raw C-API MlirModule.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the module in any way. */
static inline PyObject *mlirPythonModuleToCapsule(MlirModule module) {
  return PyCapsule_New(MLIR_PYTHON_GET_WRAPPED_POINTER(module),
                       MLIR_PYTHON_CAPSULE_MODULE, NULL);
}

/** Extracts an MlirModule from a capsule as produced from
 * mlirPythonModuleToCapsule. If the capsule is not of the right type, then
 * a null module is returned (as checked via mlirModuleIsNull). In such a
 * case, the Python APIs will have already set an error. */
static inline MlirModule mlirPythonCapsuleToModule(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_MODULE);
  MlirModule module = {ptr};
  return module;
}

/** Creates a capsule object encapsulating the raw C-API MlirPassManager.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the module in any way. */
static inline PyObject *mlirPythonPassManagerToCapsule(MlirPassManager pm) {
  return PyCapsule_New(MLIR_PYTHON_GET_WRAPPED_POINTER(pm),
                       MLIR_PYTHON_CAPSULE_PASS_MANAGER, NULL);
}

/** Extracts an MlirPassManager from a capsule as produced from
 * mlirPythonPassManagerToCapsule. If the capsule is not of the right type, then
 * a null pass manager is returned (as checked via mlirPassManagerIsNull). */
static inline MlirPassManager
mlirPythonCapsuleToPassManager(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_PASS_MANAGER);
  MlirPassManager pm = {ptr};
  return pm;
}

/** Creates a capsule object encapsulating the raw C-API MlirOperation.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the operation in any way.
 */
static inline PyObject *mlirPythonOperationToCapsule(MlirOperation operation) {
  return PyCapsule_New(operation.ptr, MLIR_PYTHON_CAPSULE_OPERATION, NULL);
}

/** Extracts an MlirOperations from a capsule as produced from
 * mlirPythonOperationToCapsule. If the capsule is not of the right type, then
 * a null type is returned (as checked via mlirOperationIsNull). In such a
 * case, the Python APIs will have already set an error. */
static inline MlirOperation mlirPythonCapsuleToOperation(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_OPERATION);
  MlirOperation op = {ptr};
  return op;
}

/** Creates a capsule object encapsulating the raw C-API MlirType.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the type in any way.
 */
static inline PyObject *mlirPythonTypeToCapsule(MlirType type) {
  return PyCapsule_New(MLIR_PYTHON_GET_WRAPPED_POINTER(type),
                       MLIR_PYTHON_CAPSULE_TYPE, NULL);
}

/** Extracts an MlirType from a capsule as produced from
 * mlirPythonTypeToCapsule. If the capsule is not of the right type, then
 * a null type is returned (as checked via mlirTypeIsNull). In such a
 * case, the Python APIs will have already set an error. */
static inline MlirType mlirPythonCapsuleToType(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_TYPE);
  MlirType type = {ptr};
  return type;
}

/** Creates a capsule object encapsulating the raw C-API MlirAffineMap.
 * The returned capsule does not extend or affect ownership of any Python
 * objects that reference the type in any way.
 */
static inline PyObject *mlirPythonAffineMapToCapsule(MlirAffineMap affineMap) {
  return PyCapsule_New(MLIR_PYTHON_GET_WRAPPED_POINTER(affineMap),
                       MLIR_PYTHON_CAPSULE_AFFINE_MAP, NULL);
}

/** Extracts an MlirAffineMap from a capsule as produced from
 * mlirPythonAffineMapToCapsule. If the capsule is not of the right type, then
 * a null type is returned (as checked via mlirAffineMapIsNull). In such a
 * case, the Python APIs will have already set an error. */
static inline MlirAffineMap mlirPythonCapsuleToAffineMap(PyObject *capsule) {
  void *ptr = PyCapsule_GetPointer(capsule, MLIR_PYTHON_CAPSULE_AFFINE_MAP);
  MlirAffineMap affineMap = {ptr};
  return affineMap;
}

#ifdef __cplusplus
}
#endif

#endif // MLIR_C_BINDINGS_PYTHON_INTEROP_H
