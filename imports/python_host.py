from ok import ok
import sys
import string


class SigGen:
    def __init__(self):
        self.writeBuf = None
        self.readBuf = None

    def InitializeDevice(self, bit_stream):
        # Open the first device we find.
        self.xem = ok.okCFrontPanel()
        if (self.xem.NoError != self.xem.OpenBySerial("")):
            print ("A device could not be opened.  Is one connected?")
            return(False)

        # Get some general information about the device.
        self.devInfo = ok.okTDeviceInfo()
        if (self.xem.NoError != self.xem.GetDeviceInfo(self.devInfo)):
            print ("Unable to retrieve device information.")
            return(False)
        print("         Product: " + self.devInfo.productName)
        print("Firmware version: %d.%d" % (self.devInfo.deviceMajorVersion, self.devInfo.deviceMinorVersion))
        print("   Serial Number: %s" % self.devInfo.serialNumber)
        print("       Device ID: %s" % self.devInfo.deviceID)

        self.xem.LoadDefaultPLLConfiguration()

        # Download the configuration file.
        if (self.xem.NoError != self.xem.ConfigureFPGA(bit_stream)):
            print ("FPGA configuration failed.")
            return(False)

        # Check for FrontPanel support in the FPGA configuration.
        if (False == self.xem.IsFrontPanelEnabled()):
            print ("FrontPanel support is not available.")
            return(False)

        print ("FrontPanel support is available.")
        return(True)


    def reset(self):
        self.xem.SetWireInValue(0x00, 0x0000_0001)
        self.xem.UpdateWireIns()
        self.xem.SetWireInValue(0x00, 0x0000_0000)
        self.xem.UpdateWireIns()
    
    def set_freq(self, fpga_clk_freq, file_freq):
        self.xem.SetWireInValue(0x05, int(fpga_clk_freq / file_freq))
        self.xem.UpdateWireIns()
    
    def select(self, choice):
        self.xem.SetWireInValue(0x02, choice)
        self.xem.UpdateWireIns()
    
    def send_data(self, buf, block_size = 32):
        # TODO: check if padding is no longer necessary for simple pipe
        # # padding
        # buf_size = len(buf)
        # print("original buf size:" , buf_size)
        # padding_size = block_size - (buf_size % block_size) # make sure the buffer size is in multiples of block size
        # buf.extend([0x0]*padding_size)
        # print("padded_buf size: " , len(buf))
        
        print("print the first 10 bytes:", buf[:10])
        print("print the last 10 bytes:", buf[-10:])
        
        self.xem.WriteToPipeIn(0x80, buf)
        
    def receive_data(self, buf):
        self.xem.ReadFromPipeOut(0xa3, buf)


##################################################################
print("--- Initialize Board ---")
bit_stream = r"C:\fpga_dac_signal_generator_spi\signal_generator_spi\signal_generator_spi.runs\impl_1\top.bit" 
# bit_stream = r"C:\fpga_dac_signal_generator_spi\output\3_choose_between_two_ram_succeeded.bit"

FPGA_CLK_FREQ =  100800000 # hz
sg = SigGen()
if (False == sg.InitializeDevice(bit_stream)):
    exit
sg.reset()

file_freq = 1008 # 8192 # hz
sg.set_freq(FPGA_CLK_FREQ, file_freq)
sg.select(0)

print("--- Start Sending Data ---")

with open('audio.dat', 'r') as f:
    num_str = f.read()
num_list =  [subitem for item in num_str.split('\n') for subitem in item.split(' ')]
num_str_concat = "".join(num_list)
num_bytesarray = bytearray.fromhex(num_str_concat)

buf = num_bytesarray.copy()
sg.send_data(buf)


print("--- Start Receiving Data ---")
buf_ret = bytearray(96) # preallocate the space for data
sg.receive_data(buf_ret)
# print(buf_ret)
with open('audio_out.dat', 'a') as f: #save data
    f.write('\n'.join(format(x, '02x') for x in buf_ret))