# Low Frequency AWID 40-bit encoding
*Commands ran via RRG PM3 client as of 10/04/2022 adjustments may be needed for previous or future versions*

[Link to Iceman/RRG Proxmark3 Github](https://github.com/rfidresearchgroup/proxmark3)

### Encoding break-down
AWID 40-bit format credentials are uncommon but do exist, the support for writing is different due to the lack of Facility Code and Card Number in these specific credentials so it cannot be automatically calculated and encoding. the alternate method is to split the raw data up into 3x8 values and write accordingly to the t5577 target device.

Below i will be using the example ![image](https://user-images.githubusercontent.com/72751518/162635550-db910226-ed0b-4d3d-94a1-a0baa4f88fa6.png)

the raw data is: **0124111181b1818d1d111111** which outputs the weigand of **020A20986**

to write this to the target device we need to split the 12 hexbyte raw into 3 sets of 4 bytes and write them to blocks 1,2 and 3 of page 0. with a block 0 of **00107060** to denote password free configuration

the commands below, written to a wiped t5577 produce a 40-bit AWID tag identicial to the orignal token 

`lf t55 write -b 0 -d 00107060 --r0`

`lf t55 write -b 1 -d 01241111 --r0`

`lf t55 write -b 2 -d 81b1818d --r0`

`lf t55 write -b 3 -d 1d111111 --r0`

*Have any questions or want to contribute to this doc add me on Discord, Equip#1515*
