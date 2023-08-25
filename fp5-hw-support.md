# Component support table

| Description                    | Component      | Mainline kernel   | Since when       |
|--------------------------------|----------------|-------------------|------------------|
| Power button                   | pmk8350 pwrkey | Working           |                  |
| Volume down button             | pmk8350 resin  | Working           |                  |
| Volume up button               | gpio-keys      | Working           |                  |
| Internal storage               | UFS            | Working           |                  |
| SD card                        | sdhc_2         | Working           |                  |
| Display                        | rm692e5        |                   |                  |
| Touchscreen                    | GT9897         | Downstream driver |                  |
| NFC                            | st21nfcd       |                   |                  |
| Vibration motor                | AW86927FCR     |                   |                  |
| Charger                        | adsp-based (pmic-glink) | Working  |                  |
| Fuel gauge                     | adsp-based (pmic-glink) | Working  |                  |
| WiFi                           | wcn6750        | Working           |                  |
| Bluetooth                      | wcn6750        | Working           |                  |
| Front camera                   | S5KJN1SQ03     |                   |                  |
| Rear camera (normal)           | IMX800         |                   |                  |
| Rear camera (ultrawide)        | IMX858         |                   |                  |
| Camera flash                   | pm7350c qcom,flash_led@ee00 | Working |               |
| Audio codec                    | WCD9385        |                   |                  |
| Speaker amp                    | AW88261FCR     |                   |                  |

## Audio path

* CPU via I2S (quinary) to AW88261FCR: speaker (and echo reference back)
* CPU via SoundWire to WCD9385: microphones (AMIC1, AMIC3, AMIC4), Type-C audio (WCD_HPH & AMIC2), HAC (WCD_AUX)
