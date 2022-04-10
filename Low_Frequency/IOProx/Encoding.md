# Encoding Prox IO to T5577 Emulator chip 

*Commands ran via RRG PM3 client as of 10/04/2022 adjustments may be needed for previous or future versions*

[Link to Iceman/RRG Proxmark3 Github](https://github.com/rfidresearchgroup/proxmark3)

### Encoding breakdown 

On the current RRG Proxmark client, the IOProx facility code is translated into hexidecimal when presented to you using `lf ioprox reader`.

When writing an ioprox to a t5577, the facility code is written as decimal so when doing `lf ioprox clone` you need to pre-emptively translate the outputted facility code from `lf ioprox reader` into decimal and use the translated value as your `-fc` parameter 

`lf io clone --vn 01 --fc 88 --cn 54738` should produce:
![image](https://user-images.githubusercontent.com/72751518/162636381-54534e91-ebde-4b68-a3df-92ba4a02f9ef.png)
