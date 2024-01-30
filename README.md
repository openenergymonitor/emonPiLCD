# emonPiLCD

The service handles display output and button press input on the emonPi v1 and emonPi v2. Code moved from the emonpi repository.

There are two sub-scripts `emonPiLCD1.py` that works with the original emonPi v1 (HD44780 LCD with PCF8574 I2c, I2C address 0x27 or 0x3f) and `emonPiLCD2.py` that works with the newer emonPi2 ssd1306 based OLED display.

Script `emonPiLCD.py` detects which emonPi version is connected by checking the I2C address returned.

## Install

- Use `sudo raspi-config` to enable I2C (enabled on emonSD as standard).
- Make sure that one wire temperature sensing is **not** enabled on GPIO 4 with the emonPi2 as this is used for the push button.
- Run the installation script:

    ./install.sh

## Manual detection of LCD on I2C bus and find out address

	$ sudo i2cdetect -y 1

Expected output is `0x27` or `0x3F` e.g.

```
pi@emonpi:~ $  sudo i2cdetect -y 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- 27 -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --   
```

