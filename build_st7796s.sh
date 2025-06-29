#!/usr/bin/env bash

# GND *
# VCC *
# SCL *
# SDA *
# RST
# DC
# CS
# BL


#      |        | 11 + 12 | GPIO18 | BL
#      |        | 13 + 14 |        |
#      |        | 15 + 16 |        |
# VCC  |    3v3 | 17 + 18 | GPIO24 | DC
# SDA  | GPIO10 | 19 + 20 | GND    |
#      |  GPIO9 | 21 + 22 | GPIO25 | RST
# SCL  | GPIO11 | 23 + 24 | GPIO11 | CS
# GND  |    GND | 25 + 26 | GPIO7  |



RST_PIN="25"
DC_PIN="24"
CS_PIN="11"
BL_PIN="18"

#export CXX=g++-12
rm -rf build
mkdir -p build
cd build
rm -rf *

# cmake -DDMA_TX_CHANNEL=7 -DDMA_RX_CHANNEL=5 -DST7796S=ON -DGPIO_TFT_DATA_CONTROL=25 -DGPIO_TFT_RESET_PIN=27 -DGPIO_TFT_BACKLIGHT=24 -DSPI_BUS_CLOCK_DIVISOR=4 -DBACKLIGHT_CONTROL=ON -DDISPLAY_SWAP_BGR=ON -DSTATISTICS=0 -DDISPLAY_ROTATE_180_DEGREES=ON ..

cmake \
-DDMA_TX_CHANNEL=7 \
-DDMA_RX_CHANNEL=5 \
-DST7796S=ON \
-DGPIO_TFT_DATA_CONTROL=${DC_PIN} \
-DGPIO_TFT_RESET_PIN=${RST_PIN} \
-DGPIO_TFT_BACKLIGHT=${BL_PIN} \
-DSPI_BUS_CLOCK_DIVISOR=60 \
-DBACKLIGHT_CONTROL=ON \
-DDISPLAY_SWAP_BGR=ON \
-DSTATISTICS=0 \
-DDISPLAY_ROTATE_180_DEGREES=ON \
..

make -j

sudo systemctl stop fbcp
sudo cp -v ./fbcp-ili9341 /usr/local/bin/fbcp
sudo systemctl start fbcp