#ifndef PLATFORM_TYPES_H_
#define PLATFORM_TYPES_H_

#include <stdint.h>
#include <inttypes.h>

#ifdef __cplusplus
extern "C" {
#endif

#define FW_HAS_64_BIT 1                   //!< 64-bit integers are supported via software emulation
#define FW_HAS_32_BIT 1                   //!< Native 32-bit support
#define FW_HAS_16_BIT 1                   //!< Native 16-bit support
#define FW_HAS_F64 1                      //!< double is available (via software)
#define SKIP_FLOAT_IEEE_754_COMPLIANCE 1  //!< Hardware FPU only does float (not double)

typedef int PlatformIntType;
#define PRI_PlatformIntType "d"

typedef unsigned int PlatformUIntType;
#define PRI_PlatformUIntType "u"

typedef PlatformIntType PlatformIndexType;
#define PRI_PlatformIndexType PRI_PlatformIntType

typedef int64_t PlatformSignedSizeType;
#define PRI_PlatformSignedSizeType PRId64

typedef uint64_t PlatformSizeType;
#define PRI_PlatformSizeType PRIu64

typedef PlatformIntType PlatformAssertArgType;
#define PRI_PlatformAssertArgType PRI_PlatformIntType

typedef PlatformIntType PlatformTaskPriorityType;
#define PRI_PlatformTaskPriorityType PRI_PlatformIntType

typedef PlatformIntType PlatformQueuePriorityType;
#define PRI_PlatformQueuePriorityType PRI_PlatformIntType

#ifndef PLATFORM_POINTER_CAST_TYPE_DEFINED
#define PLATFORM_POINTER_CAST_TYPE_DEFINED
typedef uint32_t PlatformPointerCastType;
#define PRI_PlatformPointerCastType PRIx32
#endif

#ifdef __cplusplus
}
#endif

#endif // PLATFORM_TYPES_H_
