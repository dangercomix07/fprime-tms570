// ======================================================================
// \title  TMS570UartDriver.cpp
// \author ameya
// \brief  cpp file for TMS570UartDriver component implementation class
// ======================================================================

#include "Drv/TMS570UartDriver/TMS570UartDriver.hpp"
extern "C" {
  #include "HL_sci.h"         // HALCoGen sci driver
  #include "HL_sys_common.h"
}

namespace Drv {

// ----------------------------------------------------------------------
// Component construction and destruction
// ----------------------------------------------------------------------

TMS570UartDriver ::TMS570UartDriver(const char* const compName) : TMS570UartDriverComponentBase(compName) {}

TMS570UartDriver ::~TMS570UartDriver() {}

// ----------------------------------------------------------------------
// Handler implementations for typed input ports
// ----------------------------------------------------------------------

Drv::SendStatus TMS570UartDriver ::send_handler(FwIndexType portNum, Fw::Buffer& sendBuffer) {
        // TODO return
    // 1) Transmit all bytes over HAL SCI
    // sciSend takes: (sciREGx, number_of_bytes, pointer_to_data)
    sciSend(sciREG1,
            static_cast<uint32>(sendBuffer.getSize()),
            const_cast<U8*>(sendBuffer.getData()));

    // 2) Optionally block/wait until TX complete:
    // while (!sciIsTxReady(sciREG1)) { /* spin or yield */ }

    // 3) Inform the framework we’re done with this buffer
    this->deallocate_out(0, sendBuffer);

    // 4) Notify downstream that we’re ready for more, if desired:
    this->ready_out(0);

    // 5) Return the status code
    return Drv::SendStatus::SEND_OK;
}

}  // namespace Drivers
