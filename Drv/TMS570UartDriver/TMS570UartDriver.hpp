// ======================================================================
// \title  TMS570UartDriver.hpp
// \author ameya
// \brief  hpp file for TMS570UartDriver component implementation class
// ======================================================================

#ifndef Drivers_TMS570UartDriver_HPP
#define Drivers_TMS570UartDriver_HPP

#include "Drivers/TMS570UartDriver/TMS570UartDriverComponentAc.hpp"

namespace Drivers {

class TMS570UartDriver : public TMS570UartDriverComponentBase {
  public:
    // ----------------------------------------------------------------------
    // Component construction and destruction
    // ----------------------------------------------------------------------

    //! Construct TMS570UartDriver object
    TMS570UartDriver(const char* const compName  //!< The component name
    );

    //! Destroy TMS570UartDriver object
    ~TMS570UartDriver();

  PRIVATE:
    // ----------------------------------------------------------------------
    // Handler implementations for typed input ports
    // ----------------------------------------------------------------------

    //! Handler implementation for send
    //!
    //! Port invoked to send data out the driver
    Drv::SendStatus send_handler(FwIndexType portNum,    //!< The port number
                                 Fw::Buffer& sendBuffer  //!< Data to send
                                 ) override;
};

}  // namespace Drivers

#endif
