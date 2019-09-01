#ifndef MPX_G3_MEMORY_API_V1

#define MPX_G3_MEMORY_API_V1

#include <avr/eeprom.h>


EEMEM unsigned char	e_mode;
EEMEM unsigned char	e_serie;
EEMEM unsigned char e_power;

#ifdef USE_FAV
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
#endif

#ifdef ECONOM_ENABLED
	EEMEM unsigned char e_econom;
#endif

void check_all(){
	if (mode>MODE_NUM){
		mode=1;
	}
	
	if (serie>S_NUM){
		serie=1;
	}
	if (serie<0){
		serie=1;
	}	
	
	#ifdef USE_FAV
		unsigned char i;
		for (i=0; i<FAV_MAX; i++){
			if (modes[i]>MODE_NUM) modes[i]=1;
			if (series[i]>S_NUM) series[i]=1;
		}
		
		if (counter>FAV_MAX) counter=0;
		if (pointer>=counter) pointer=counter;
		
		if (fav_on>1) fav_on=0;
	#endif
	
	
}

void read_data(){
	
	mode = eeprom_read_byte(&e_mode);//Чтение
	serie = eeprom_read_byte(&e_serie);//Чтение
	
	#ifdef USE_FAV	
		eeprom_read_block(modes, fm, FAV_MAX);
		eeprom_read_block(series, sm, FAV_MAX);
		
		pointer = eeprom_read_byte(&e_pointer);//Чтение		
		counter = eeprom_read_byte(&e_counter);//Чтение		
		fav_on = eeprom_read_byte(&e_fav_on);//Чтение		
	#endif
	
	#ifdef ECONOM_ENABLED
		econom = eeprom_read_byte(&e_econom);
	#endif
	check_all();
}

void store_data(){
	eeprom_write_byte(&e_mode,   mode);//Запись
	eeprom_write_byte(&e_serie,   serie);//Запись
	
	 #ifdef USE_FAV	
		eeprom_write_block(modes, fm, FAV_MAX);
		eeprom_write_block(series, sm, FAV_MAX);
		
		eeprom_write_byte(&e_pointer,  pointer);//Запись	
		eeprom_write_byte(&e_counter,  counter);//Запись	
		eeprom_write_byte(&e_fav_on,   fav_on);//	
	#endif
	
	#ifdef ECONOM_ENABLED
		eeprom_write_byte(&e_econom, econom);
	#endif
}

#endif
