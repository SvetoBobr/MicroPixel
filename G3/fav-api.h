// fav utils
#define FAV_MAX  15

#include <avr/eeprom.h>

unsigned char modes[FAV_MAX+1];
unsigned char series[FAV_MAX+1];
unsigned char counter;
unsigned char pointer;
unsigned char fav_on;

EEMEM unsigned char	fm[FAV_MAX+1];
EEMEM unsigned char	sm[FAV_MAX+1];
EEMEM unsigned char e_counter;
EEMEM unsigned char e_pointer;
EEMEM unsigned char e_fav_on;
