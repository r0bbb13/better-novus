# Access Conditions for Mifare classic
*Have any questions or want to contribute to this doc add me on Discord, Equip#1515*

Access bits are the 3 bytes of hex found in bytes 6,7 and 8 of a sector trailer in mifare classic tokens in between KeyA and KeyB, byte 9 of the sector trailer is non-important data defined by the user and has no bearing on the access conditions of that sector. 

The access conditions detail exactly how each block of that sector (including the sector trailer) can be read, written to and managed.

the factory default or "transport" configuration of these access bits is `FF0780` with the USR byte being `69` they define the access conditions to be:

![image](https://user-images.githubusercontent.com/72751518/163018064-721ee438-ad69-4635-a023-392d4921ec9f.png)

in many cases, access control management wont edit these access conditions as they are effective already. 

---

## Encoding and Decoding access bits
*all info is taken from the MF1S50 mifare classic datasheet [link](https://github.com/equipter/novus/blob/main/Datasheets/Mifare/MF1S50YYX_V1.pdf)*

**TBC**
