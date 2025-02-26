# Component support table

| Description                    | Component                |
|--------------------------------|--------------------------|
| Power button                   | Qualcomm PM8953 pwrkey   |
| Volume down button             | Qualcomm PM8953 resin    |
| Volume up button               | GPIO button              |
| Internal storage               | sdhc_1                   |
| SD card                        | sdhc_2                   |
| Display                        | Himax HX83112B           |
| Touchscreen                    | Himax HX83112B           |
| NFC                            | NXP NQ310                |
| Vibration motor                | Qualcomm PMI632 vibrator |
| Notification LED               | Qualcomm PMI632 RGB      |
| Charger                        | Qualcomm PMI632 smb5     |
| Fuel gauge                     | Qualcomm PMI632 qg       |
| WiFi                           | Qualcomm WCN3680B        |
| Bluetooth                      | Qualcomm WCN3680B        |
| FP3 front camera               | Samsung S5K4H7YX         |
| FP3 rear camera                | Sony IMX363              |
| FP3+ front camera              | Samsung S5K3P9SP         |
| FP3+ rear camera               | Samsung S5KGM1SP03-FGX9  |
| Camera flash                   | Qualcomm PMI632 flash    |
| Audio codec                    | Qualcomm WCD9326         |
| FP3 speaker amp                | Awinic AW8898            |
| FP3+ speaker amp               | TI TAS2557               |

## Audio path

* CPU via I2S (quinary) to AW8898 (FP3) / TAS2557 (FP3+): speaker
* CPU via SLIMbus to WCD9326: microphones, headphones, etc.
    * AMIC2 (using MIC_BIAS2) for headset mic
    * DMIC1 (using MIC_BIAS1) for main microphone next to USB port
    * DMIC2 (using MIC_BIAS3) for secondary microphone on top
    * HPH output is headset output (wired headphones)
    * EAR output is 'receiver' output (top speaker for calls)
