# NTAG I2C Recovery using APDU Raw commands 
*Scripts Linked are from equipter script listing available in the RRG Iceman Client as of 10/04/2022*
[Link to Equipter Scripts Github](https://github.com/equipter/Scripts/blob/main/Lua/Proxmark/hf_14a_i2crevive.lua)
[Link to Iceman/RRG Proxmark3 Github](https://github.com/rfidresearchgroup/proxmark3)

### Raw Command breakdown 
NTAG I2C can often get themselves a bit tangled if the write proccess is interrupted or if values are written incorrectly. the APDUs listed below sent via a raw communicator like NFC-Shell or the raw function on the proxmark work to unbrick the state of the tag.

`A203E1106D00`

`A20244000F00`

`A2E20000FF00`

`A2E3000000E3`

*Have any questions or want to contribute to this doc add me on Discord, Equip#1515*
