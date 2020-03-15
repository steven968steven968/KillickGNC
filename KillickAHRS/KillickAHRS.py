import time
import spidev


spi = spidev.SpiDev() # Enable SPI
spi.open(0, 0) # open (bus, chip select)
spi.max_speed_hz = 500000 # set spi speed
spi.mode = 0 # set SPI mode


time.sleep(1) # wait for sensor to stabilize


def getGyroRate():

    byte_1 = 0x01<<5 #request data
    msg = [byte_1,0x00,0x00,0x00]
    reply = spi.xfer(msg) # reply list of integers
    
    reply_conc = 0
    for n in reply:
        reply_conc = (reply_conc << 8) + n # concanate list of integers into one integer
    rate_raw = reply_conc >> 10 & 0xFFFF # remove first 6 bits and last 10 bits
    
    # +ve LSB rotation: 0x0001-0x7FFF (1-32767)
    # no rotation: 0x0000 (0)
    # -ve LSB rotation: 0xFFFF-0x8000 (65535-32768)
    if rate_raw >= 1 and rate_raw <= 0x7FFF: 
        rate_lsb = rate_raw
    elif rate_raw >= 0x8000 and rate_raw <= 0xFFFF:
        rate_lsb = -1 * (0x10000 - rate_raw)
    else:
        rate_lsb = 0
    
    rate_rad = round((rate_lsb / 80) * 0.0174533, 6) # 80LSB/deg/s, convert to rad/s
    
    return rate_rad




while True:
    
    omega = getGyroRate()
    #display data
    print("Angular Velocity:", omega, "rad/s")
    time.sleep(0.1)