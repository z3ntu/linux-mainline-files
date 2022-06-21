# Component support table

| Description                    | Component      | Mainline kernel   | Since when       |
|--------------------------------|----------------|-------------------|------------------|
| Power button                   | pm8953 pwrkey  | Working           |                  |
| Volume down button             | pm8953 resin   | Working           |                  |
| Volume up button               | gpio-keys      | Working           |                  |
| Internal storage               | sdhc_1         | Working           |                  |
| SD card                        | sdhc_2         | Working           |                  |
| Display                        | hx83112b       | Working           |                  |
| Touchscreen                    | hx83112b       | Working           |                  |
| NFC                            | NXP NCI        |                   |                  |
| Vibration motor                | pmi632 qcom,vibrator@5700 |        |                  |
| Notification LED               | pmi632 qcom,leds@d000 |            |                  |
| Charger                        | pmi632 qcom,qpnp-smb5 |            |                  |
| Fuel gauge                     | pmi632 qpnp,qg |                   |                  |
| WiFi                           | pronto?        |                   |                  |
| Bluetooth                      | pronto?        |                   |                  |
| FP3 front camera               | S5K4H7YX       |                   |                  |
| FP3 rear camera                | IMX363         |                   |                  |
| FP3+ front camera              | S5K3P9SP       |                   |                  |
| FP3+ rear camera               | S5KGM1SP03-FGX9|                   |                  |
| Camera flash                   | pmi632 qcom,leds@d300 |            |                  |
| Audio codec                    | WCD9326        |                   |                  |
| FP3 speaker amp                | AW8898         |                   |                  |
| FP3+ speaker amp               | TAS2557        |                   |                  |

## Audio path

* CPU via I2S (quinary) to AW8898/TAS2557: speaker (and echo reference back)
* CPU via SLIMbus to WCD9326: microphones, headphones, etc.
