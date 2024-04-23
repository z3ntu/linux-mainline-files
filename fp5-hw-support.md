# Component support table

| Description                    | Component      | Mainline kernel   |
|--------------------------------|----------------|-------------------|
| Power button                   | PMK7325 pwrkey | Working           |
| Volume down button             | PMK7325 resin  | Working           |
| Volume up button               | GPIO button    | Working           |
| Internal storage               | UFS            | Working           |
| SD card                        | sdhc_2         | Working           |
| Display                        | BF065GBM-TK0-7DP0 (RM692E5 driver IC) | Working |
| Touchscreen                    | GT9897         | Downstream driver |
| NFC                            | ST21NFCD       |                   |
| Vibration motor                | AW86927FCR     |                   |
| Charger                        | PM7250B (via pmic-glink) | Working |
| Fuel gauge                     | PM7250B (via pmic-glink) | Working |
| WiFi                           | WCN6750        | Working           |
| Bluetooth                      | WCN6750        | Working           |
| Front camera                   | S5KJN1SQ03     |                   |
| Rear camera (main)             | IMX800         |                   |
| Rear camera (ultrawide)        | IMX858         |                   |
| Camera flash                   | PM7350C        | Working           |
| Audio codec                    | WCD9385        |                   |
| Speaker amp                    | AW88261FCR     |                   |

## Audio path

* CPU via I2S (quinary) to AW88261FCR: speaker (and echo reference back)
* CPU via SoundWire to WCD9385: microphones (AMIC1, AMIC3, AMIC4), Type-C audio (WCD_HPH & AMIC2), HAC (WCD_AUX)

## Cameras

| Purpose           | Model      | PHY   |
|-------------------|------------|-------|
| Front             | S5KJN1SQ03 | D-PHY |
| Rear (main)       | IMX800     | C-PHY |
| Rear (ultra-wide) | IMX858     | D-PHY |
