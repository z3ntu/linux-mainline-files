# Component support table

| Component                      | Codename       | Mainline kernel   | Since when       |
|--------------------------------|----------------|-------------------|------------------|
| Volume & camera buttons        | gpio-keys      | Working           | v4.15-rc1        |
| Power key                      | pm8941-pwrkey  | Working           | already upstream |
| Internal storage               | sdhci1         | Working           | v4.15-rc1        |
| SD card storage                | sdhci2         | Working           | v4.16-rc1        |
| Old Display                    | otm1902b       | Kind-of working   | out-of-tree      |
| Old Touchscreen                | Synaptics DSX? | Kind-of working   | out-of-tree      |
| New Display                    | s6d6fa1        | Working           | out-of-tree      |
| New Touchscreen                | Ilitek ili2120 | Working           | v5.19-rc1        |
| Vibration motor                | TI DRV2603     | Working           | v5.3-rc1         |
| Notification LED               | qpnp / lpg     | Working           | v6.0-rc1         |
| Magnetometer                   | AK8963         | No driver{DSP}    |                  |
| Gyroscope & Accelerometer      | LSM330D        | No driver{DSP}    |                  |
| Proximity & Light              | Murata LT1PA01 | No driver{DSP}    |                  |
| WiFi                           | WCN3680/prima  | Working           | v5.6-rc1         |
| Bluetooth                      | WCN3680        | Working           | v5.6-rc1         |
| FM                             | WCN3680        | No driver         |                  |
| GPU                            | Adreno 330     | Working           | out-of-tree      |
| Modem                          | msm8974-mss-pil| Working           | v5.6-rc1         |
| Old Front Camera               | OV2685         | Working (WIP)     | out-of-tree      |
| Old Rear Camera                | OV8865         | Working (WIP)     | out-of-tree      |
| New Front Camera               | OV5670         | Working (WIP)     | out-of-tree      |
| New Rear Camera                | OV12870        | No driver         |                  |

<references>
<ref name="DSP">Connected to the DSP and the driver is implemented in the ADSP firmware. Would need a kernel or user space implementaion talking QMI to the ADSP to plumb the sensors to user space where it can be used for e.g. rotation.</ref>
</references>

# Test notes

## Power key
```
evtest /dev/input/event0
```

## Volume & camera buttons
```
evtest /dev/input/event1
```

## Touchscreen
```
evtest /dev/input/event2
```

## Vibration motor
```
fftest /dev/input/event3
```

## Internal storage
```
ls /dev/mmcblk0*
```

## SD card storage
```
ls /dev/mmcblk1*
```

## Display

Framebuffer console should display the kernel messages
```
ls -al /dev/fb0
echo 255 > /sys/class/backlight/fd922800.dsi.0/brightness
```

## GPU
```
kmscube
```

## Notification LED
```
echo 255 > /sys/class/leds/rgb\:status/brightness
```

## WiFi / Bluetooth / FM
```
echo start > /sys/class/remoteproc/remoteprocX/state
# set mac address according to "MAC addresses" section
# wifi and bluetooth interfaces should just work
```

Regarding FM:

> someone was doing some initial work, but i got the feeling that without lpass running it didn't want to play ball

### MAC addresses
```
$ qmicli -d /dev/wwan0qmi0 --dms-get-mac-address wlan
$ ip link set dev wlan0 address 12:34:56:78:9A:BC

$ qmicli -d /dev/wwan0qmi0 --dms-get-mac-address bt
# Note, that the bluetooth mac address is backwards (e.g. BC:9A:78:56:34:12 is actually 12:34:56:78:9A:BC)
# You can reverse the mac address using the following script:
$ echo BC:9A:78:56:34:12 | awk 'BEGIN{FS=OFS=":"} {s=$NF; for (i=NF-1; i>=1; i--) s = s OFS $i; print s}'
$ btmgmt public-addr 12:34:56:78:9A:BC
```

It looks like the Bluetooth initialization (including querying the MAC address via QMI and setting it) is done with hci_qcomm_init on downstream (`init.qcom.bt.sh`). It looks like there is no official public source version available for that.

For WiFi this seems to be done with libwcnss_qmi.so, a source version of that can be found [here](https://github.com/LineageOS/android_hardware_qcom_wlan/blob/lineage-16.0-caf/wcnss-service/wcnss_qmi_client.c).

## Sensors

Notes from IRC:

> the client would need to implement the sensor qmi protocols, which we haven't tried to open up
> 
> qmi is just a method of encoding structured data; exactly like protobuf
> 
> libqmi implements a set of protocols that uses qmi to encode its data
> 
> so there's another set of 10-15 protocols, that uses qmi to encode messages, related to sensors
> 
> i think these are implemented in libsensors1.so - or something like that
> 
> but iirc libsensors1 is tied to the downstream AF_MSMIPC, and won't work on AF_QIPCRTR

Further notes: https://gitlab.freedesktop.org/mobile-broadband/libqmi/issues/21

## Modem

The modem gets detected with ofono but you need to do additional manual setup because it's a Dual SIM device: https://wiki.postmarketos.org/wiki/User:TravMurav/Dual-Sim_QMI_draft

The `msm-modem-uim-selection` package should handle this but hasn't been tested yet.

## Mobile Data

~~Upstream kernel contains rmnet core driver (equivalent to downstream `msm_rmnet.c`) but not the platform specific part (or rather transport specific part). `./drivers/net/ethernet/msm/msm_rmnet_bam.c` is (likely) used on downstream msm8974. Newer Qualcomm devices use the IPA driver but 8974 is older than that. The actual transport used is `arch/arm/mach-msm/bam_dmux.c`.~~

Mobile Data is working! ~~At the moment these resources are required:~~
* https://gitlab.com/postmarketOS/linux-postmarketos/-/commits/qcom-msm8974-5.9.y-bam
* dual-sim things from Modem section
* https://gist.github.com/Minecrell/4cc2bfb9fcae18e294386b0a213907d1
* https://gitlab.com/Minecrell/pmaports/-/commit/2684abff23560dc0b5d8cb9f20baec2a28c3d0a8
* For APN the following procedure is needed for my SIM card: `./enable-modem && ./online-modem && ./remove-contexts && ./create-internet-context webaut && ./activate-context 1`

The above should all be integrated now.

## Cameras

**Old modules:**
* Front: OV2685
* Back: OV8865

**New modules:**
* Front: OV5670
* Back: OV12870 (no sensor driver in Linux)

The cameras can produce a picture that can be displayed using the libcamera qcam test utility. Possibly other libcamera-based apps also might work.

Currently based on a separate kernel branch (might change), you anyways also need to rebuild your dtb with the correct camera sensors manually enabled. There's no dynamic runtime detection support. Not sure if that's even possible in Linux itself.

Replace `/boot/dtbs/qcom-msm8974pro-fairphone-fp2.dtb` and run `sudo postmarketos-mkinitfs` to update `boot.img` in `/boot/`.

Then you can try running `qcam`:
```
# Adjust environment variables to be able to launch app via SSH
eval $(cat /proc/`pidof phosh`/environ | tr '\0' '\n' | grep -v '^PS1=' | awk '{ print "export \"" $0 "\"" }')
```

### OV2685
```
QT_QPA_PLATFORM=wayland qcam -v -r gles
```

### OV8865
```
v4l2-ctl -d /dev/v4l-subdev19 -c exposure=2500
QT_QPA_PLATFORM=wayland qcam -v -r gles -s width=3264,height=1836
```
(all other sizes don't deliver any data correctly)

### OV5670
```
QT_QPA_PLATFORM=wayland qcam -v -r gles -s width=1280,height=720
```

## Camera Flash LED

### Old camera module

The flash in the old camera module is controlled by the pm8941 and this hardware block is accessible on the address @d300. The qcom-lpg driver used for the notification LED is relatively similar but it should be a separate driver for the camera flash.

A driver was posted to LKML in 2020.

### New camera module

For the new camera module (12MP one) the following driver is being used:
```
# cat /sys/devices/fda0c000.qcom,cci/c6.ti,flash0/leds/torch_dual/device/uevent
DRIVER=leds-lm3644
OF_NAME=ti,flash0
OF_FULLNAME=/soc/qcom,cci@fda0C000/ti,flash0@c6
OF_COMPATIBLE_0=ti,lm3644
OF_COMPATIBLE_N=1
MODALIAS=of:Nti,flash0T<NULL>Cti,lm3644
```

The situation seems to be more complicated than with the old module as the lm3644 driver takes over parts of the driver controlling pm8941@d300, which might be complicated to solve nicely on mainline.

The lm3644 is an i2c device sitting on the camera interface i2c bus. There's no driver in mainline for the lm3644 yet.

http://www.ti.com/lit/ds/symlink/lm3644.pdf

## Audio

An initial (unsuccessful) test with out-of-tree patches from flto was done with the following config options: `CONFIG_SLIMBUS`, `CONFIG_SLIM_QCOM_CTRL`, `CONFIG_SLIM_QCOM_NGD_CTRL`, `CONFIG_QCOM_APR`, `CONFIG_SND_SOC_WCD9320`, `CONFIG_SND_SOC_QCOM`, `CONFIG_SND_SOC_LPASS_*`, `CONFIG_SND_SOC_QDSP6_*`, `CONFIG_SND_SOC_MSM8996`.

Headphone audio kind of works with one or both of these branches:
* https://github.com/z3ntu/linux/commits/flto-msm8974
* https://github.com/z3ntu/linux/commits/flto-msm8974-5.11

## Others

See [Brian Masney's Nexus 5 mainline to-do list](https://masneyb.github.io/nexus-5-upstream/TODO.html).

# Kernel config options

Base config: `qcom_defconfig`

| Kernel config option             | Function           |
|----------------------------------|--------------------|
| CONFIG_USB_ETH_RNDIS             | USB networking     |
| CONFIG_INPUT_PM8941_PWRKEY       | Power key          |
| CONFIG_DRM_PANEL_SIMPLE          | Display            |
| CONFIG_DMA_CMA                   | Also display       |
| CONFIG_TOUCHSCREEN_ILI210X       | Touchscreen        |
| CONFIG_INPUT_GPIO_VIBRA          | Vibration motor    |
| CONFIG_LEDS_QCOM_LPG             | Notification leds  |
| CONFIG_WCN36XX                   | WiFi               |
| CONFIG_BT_QCOMSMD                | Bluetooth          |
| CONFIG_BATTERY_BMS               | Battery fuel gauge |
| CONFIG_SYSCON_REBOOT_MODE        | Reboot mode        |
| CONFIG_I2C_QCOM_CCI              | Camera Control Interface |

## cmdline

```
earlycon=msm_serial_dm,0xf991e000 PMOS_NO_OUTPUT_REDIRECT clk_ignore_unused pd_ignore_unused cma=500m msm.vram=192m msm.allow_vram_carveout=1
```
