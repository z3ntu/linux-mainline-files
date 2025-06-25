# Component support table

| Description                    | Component               |
|--------------------------------|-------------------------|
| Power button                   | Qualcomm PMK7635 pwrkey |
| Volume down button             | Qualcomm PMK7635 resin  |
| Volume up button & Switch      | GPIO button             |
| Internal storage               | UFS                     |
| SD card                        | sdhc_2                  |
| Display                        | Boe BJ631JHM-T71-D900   |
| Touchscreen                    | Eswin EPH8621           |
| NFC                            | Samsung S3NRN4VX        |
| Vibration motor                | Awinic AW86938FCR       |
| Charger                        | Qualcomm PMIV0108 (via pmic-glink) |
| Fuel gauge                     | Qualcomm PMIV0108 (via pmic-glink) |
| WiFi                           | Qualcomm WCN6755        |
| Bluetooth                      | Qualcomm WCN6755        |
| Front camera                   | Samsung S5KKD1          |
| Rear camera (main)             | Sony IMX896             |
| Rear camera (ultrawide)        | Omnivision OV13B10      |
| Camera flash                   | Qualcomm PM7550         |
| Audio codec                    | Qualcomm WCD9378        |
| Speaker amp                    | Awinic AW88261FCR       |

## Audio path

* CPU via I2S (senary?) to AW88261FCR: speaker
* CPU via SoundWire to WCD9378: microphones (AMIC1, AMIC3)

## Cameras

| Purpose           | Model      | PHY   |
|-------------------|------------|-------|
| Front             | S5KKD1     | D-PHY |
| Rear (main)       | IMX896     | C-PHY |
| Rear (ultra-wide) | OV13B10    | D-PHY |
