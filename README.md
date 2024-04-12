
# meta-robomagister

Powered at 12V


## Tests

Status | Test | Note
:-:|:-:|:-:
OK | Linux Console |
OK | SD Card |
OK | Wifi |
OK | Bluetooth |
OK | RTC |
OK | CAN |
Do Not Test | PCIe (Key M) |
OK | Audio |
OK | Microphone |
Do Not Test | MIPI-DSI |
OK | LVDS |
OK | Touch |
OK | Backlight |
OK | Relè |
OK | mcp3021 |



## WIFI

```

echo 1 > /sys/class/gpio/WL_PD_N/value

modprobe moal mod_para=nxp/wifi_mod_para.conf
ifconfig mlan0 up
iw dev mlan0 scan | grep SSID
wpa_passphrase engicam_guest GU-engicam  > /etc/wpa_supplicant.conf
wpa_supplicant -imlan0 -Dnl80211 -c/etc/wpa_supplicant.conf -B
udhcpc -imlan0
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

### esempio ciclo di powerdown


```
# messo in powerdown
echo 0 > /sys/class/gpio/WL_PD_N/value
modprobe moal mod_para=nxp/wifi_mod_para.conf
rmmod moal

# tolto dal powerdown
echo 1 > /sys/class/gpio/WL_PD_N/value

```


## BLUETOOTH

```
hciattach -b /dev/ttymxc2 any 3000000 flow
hciconfig hci0 up
hcitool scan
```

## RTC

```
dmesg | grep pcf8523

[    2.074064] rtc-pcf8523 1-0068: registered as rtc1
```

## CANBUS

```
echo 0 > /sys/class/gpio/CAN_SILENT/value 

ip link set can0 type can bitrate 125000
ifconfig can0 up
cantest can0 &
cantest can0 5A1#11.2233.44556677.88
```

### AUDIO

```
echo 1 > /sys/class/gpio/SPKR_EN/value
echo 0 > /sys/class/gpio/SPKR_EN/value

wget https://www.wavsource.com/snds_2020-10-01_3728627494378403/movies/misc/adventures_babysitter.wav
aplay adventures_babysitter.wav 
```

### Microphone

```
arecord -d 5 -f S16_LE /tmp/test-mic.wav
aplay /tmp/test-mic.wav 
```

### BackLight

```
cd /sys/class/backlight/lvds_backlight
echo 100 > brightness
echo 10 > brightness

```

## Relè

```
## on 
echo 1 > /sys/class/gpio/12V_EXT_ON/value 

## off
echo 0 > /sys/class/gpio/12V_EXT_ON/value 

## on
echo 1 > /sys/class/gpio/USB_EXT_EN/value

## off
echo 0 > /sys/class/gpio/USB_EXT_EN/value
```

## mcp3021


CONFIG_SENSORS_MCP3021

```
echo 1 > /sys/class/gpio/12V_EXT_ON/value
cat /sys/class/hwmon/hwmon0/device/in0_input 
2830

echo 0 > /sys/class/gpio/12V_EXT_ON/value
cat /sys/class/hwmon/hwmon0/device/in0_input 
971
```






-------------------------------------


rm -rf ../modules
make INSTALL_MOD_PATH=../modules/ modules_install
rm ../modules/lib/modules/5.15.71*/build
rm ../modules/lib/modules/5.15.71*/source


dd if=/mnt/engicam-evaluation-image-mx8-imx8mp-icore-fasteth-robomagister.wic  of=/dev/mmcblk2 bs=12M && sync
