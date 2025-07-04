module Drv {
    passive component TMS570UartDriver {

        @ Port invoked when the driver is ready to send/receive data
        output port ready: Drv.ByteStreamReady

        @ Port invoked when driver has received data
        output port $recv: Drv.ByteStreamRecv

        @ Port invoked to send data out the driver
        guarded input port $send: Drv.ByteStreamSend

        @ Allocation port used for allocating memory in the receive task
        output port allocate: Fw.BufferGet

        @ Deallocates buffers passed to the "send" port
        output port deallocate: Fw.BufferSend

        ###############################################################################
        # Standard AC Ports: Required for Channels, Events, Commands, and Parameters  #
        ###############################################################################
        @ Port for requesting the current time
        time get port timeCaller

        @ Command receive
        command recv port cmdIn

        @ Command registration
        command reg port cmdRegOut

        @ Command response
        command resp port cmdResponseOut

        @ Parameter get
        param get port prmGetOut

        @ Parameter set
        param set port prmSetOut

        @ Event
        event port eventOut
        
        @ Text event
        text event port textEventOut

       

    }
}