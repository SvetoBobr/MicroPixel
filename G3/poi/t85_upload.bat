 
C:\avr\FTBB\avrdude.exe -p t85 -c ftbb -Pft0 -B 9600 -U lfuse:w:0xe2:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m

C:\avr\FTBB\avrdude.exe -p t85 -c ftbb -Pft0 -B 76800 -U flash:w:.\filename.bin:r
timeout  15
