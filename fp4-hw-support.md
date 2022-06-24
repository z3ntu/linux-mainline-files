# Component support table

| Description                    | Component      | Mainline kernel   | Since when       |
|--------------------------------|----------------|-------------------|------------------|
| Power button                   | pm6350 pwrkey  |                   |                  |
| Volume down button             | pm6350 resin   |                   |                  |
| Volume up button               | gpio-keys      |                   |                  |
| Internal storage               | UFS            |                   |                  |
| SD card                        | sdhc_2         |                   |                  |
| Display                        | hx83112a       |                   |                  |
| Touchscreen                    | hx83112a       |                   |                  |
| NFC                            | st21nfcd       |                   |                  |
| Vibration motor                | aw8695         |                   |                  |
| Charger                        | pm7250b qcom,qpnp-smb5 |           |                  |
| Fuel gauge                     | pm7250b qpnp,qg |                  |                  |
| WiFi                           | wcn3988/wcn3990 |                  |                  |
| Bluetooth                      | wcn3988/wcn3990 |                  |                  |
| Front camera                   | IMX576         |                   |                  |
| Rear camera (normal)           | IMX582         |                   |                  |
| Rear camera (ultrawide)        | IMX582         |                   |                  |
| Camera flash                   | pm6150l qcom,leds@d300 |           |                  |
| Audio codec                    | WCD9380        |                   |                  |
| Speaker amp                    | AW88264        |                   |                  |

## Audio path

* CPU via I2S (quinary) to AW88264: speaker (and echo reference back)
* CPU via SoundWire to WCD9380: microphones, etc.
