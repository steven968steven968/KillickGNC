import spidev
import RPi.GPIO as GPIO
import numpy as np
from pyquaternion import Quaternion as quat
import time

def setSPI():
    spi.open(0, 0) # (bus, chip select)
    spi.max_speed_hz = 500000
    spi.mode = 0

def setGPIO():
    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BCM)
    for gpioNumber in range (22,26):
        GPIO.setup(gpioNumber, GPIO.OUT)
        GPIO.output(gpioNumber, GPIO.LOW)
     
def getBodyRate():
    axisList = ['0001', '1001', '0101'] # decoder bits combination for gyro x,y,z axis
    body_rate = []
    
    for axis in axisList: # loop through all axis
        addr = range(22,26) # decoder GPIO pin number
        bits = [int(x) for x in axis] # list of bits
        for addr, bits in zip(addr, bits):
            GPIO.output(addr, bits) # set decoded bit combination #print(addr,bits)
                    
        reply = spi.xfer([0x01<<5,0x00,0x00,0x00]) # read sensor
        reply_conc = 0
        for n in reply:
            reply_conc = (reply_conc << 8) + n # concanate list of integers into one integer
        rate_raw = reply_conc >> 10 & 0xFFFF # remove first 6 bits and last 10 bits
        
        # +ve LSB rotation: 0x0001-0x7FFF (1-32767)
        # no rotation: 0x0000 (0)
        # -ve LSB rotation: 0xFFFF-0x8000 (65535-32768)
        if rate_raw >= 0x00 and rate_raw <= 0x7FFF: 
            rate_lsb = rate_raw
        elif rate_raw >= 0x8000 and rate_raw <= 0xFFFF:
            rate_lsb = -(0x10000 - rate_raw)
        
        rate_rad = -rate_lsb/80*0.0174533 # 80LSB/deg/s, convert to rad/s
        body_rate.append(round(rate_rad, 6)) # append 3 axis to a list, fix sign
        
    return body_rate
    

def getBodyAccl():
    addr = range(22,26) # decoder GPIO pin number
    bits = [int(x) for x in '1010'] # decoder bit combination
    for addr, bits in zip(addr, bits):
        GPIO.output(addr, bits) # set decoded bit combination #print(addr,bits)
    
    body_accl = []
    data_raw = spi.xfer([((XDATA3<<1)|0x01),0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0]) # read bit --> 0x01
    del data_raw[0] # first element of reply list is useless
    
    ax_raw = (data_raw[0] << 12) + (data_raw[1] << 4) + (data_raw[2] >> 4)
    ay_raw = (data_raw[3] << 12) + (data_raw[4] << 4) + (data_raw[5] >> 4)
    az_raw = (data_raw[6] << 12) + (data_raw[7] << 4) + (data_raw[8] >> 4)
    
    # scale factor:  3.9e-6G/LSB for 2G range
    # FSR: +/-2.048G --> +/-525128.2051 LSB --> 0x80348
    for axis_raw in [ax_raw, ay_raw, az_raw]:
        if axis_raw > 0x80348 and axis_raw <= 0xFFFFF: 
            axis_raw = 0x100000 - axis_raw
        elif axis_raw >= 0x00 and axis_raw <= 0x80348:
            axis_raw = -axis_raw
        
        accl_ms2 = axis_raw*3.9e-6*9.80665
        body_accl.append(round(accl_ms2, 6))
    
    return body_accl

  
    
#RIEKF

# 1. initialize

# GYRO: ADXRS453 X&Y axis
# FFT (rate) noise density @ 25C = 0.015 deg/s/sqrt_hz
# angular random walk @ 40C = 0.005 deg/sqrt_s from Allan Plot
# bias instability @ 40C = 0.0044 deg/s from Allan Plot



# accl: ADXL355
# magt: BMM150
# 
# w = np.diag([?,?,?]) # process noise stdev
# 
# w = np.array([[0,0,0],
#               [0,0,0],
#               [0,0,0]]) # measurement noise stdev
# 
# x_hat # initialize from sensor start up
# Qw # process noise covariance
# Rv # measurement noise covariance
# 
# P # covariance
# 
# K # kalman gain
# 
# Qd # process noise covariance-map to state space (linearized)
# Rd # measurement noise covariance-map to state space (linearized)
# 
# F # state jacobian
# H # measurement jacobian
# 
# Gw # state noise jacobian
# Gv # measurement noise jacobian
# 
# PHI # state transition matrix



spi = spidev.SpiDev()
setSPI()
setGPIO()

#register addresses
XDATA3 = 0x08
FIFO_DATA = 0x11
RANGE = 0x2C
FILTER = 0x28
POWER_CTL = 0x2D

# device values
RANGE_MODE = 0x01 # 2G
FILTER_MODE = 0x02 # no HPF, 250Hz LPF, 1kHz ODR
MEASURE_MODE = 0x02 # accelerometer only

addr = range(22,26) # decoder GPIO pin number
bits = [int(x) for x in '1010'] # decoder bit combination
for addr, bits in zip(addr, bits):
    GPIO.output(addr, bits) # set decoded bit combination #print(addr,bits)

spi.xfer([((RANGE<<1)|0x00), RANGE_MODE]) # write bit --> 0x00
spi.xfer([((FILTER<<1)|0x00), FILTER_MODE])
spi.xfer([((POWER_CTL<<1)|0x00), MEASURE_MODE])

time.sleep(0.5) # wait for sensor to stabilize

while True:
    omega = getBodyRate()
    accel = getBodyAccl()

    print("Body Angular Rate:", omega, "rad/s")
    print("Body Acceleration:", accel, "m/s^2")
    time.sleep(0.1)



