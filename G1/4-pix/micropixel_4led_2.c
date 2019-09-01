// t45	attiny45	76800 prog
// board	MMCU		programm_after_make
//38400


//
#define F_CPU 8000000
#define CPU_TYPE	 T45

#define FRAME_DELAY 3
#define MAX_LEVEL	255
#define HALF_LEVEL	60
#define PACK_SIZE	10

#define BOARD GDCV
#include "../../boards.h"

#include "../apa102-driver.c"

#include <avr/io.h>
#include <util/delay.h>

#include "../palette_7.c"

#include <avr/eeprom.h>

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );

//modes
#define MODE_NUM	10
#define S_NUM	15

unsigned char mode;
unsigned char s, ss;
unsigned char power;

EEMEM unsigned char	e_mode;
EEMEM unsigned char	e_serie;
EEMEM unsigned char	e_s_serie;
EEMEM unsigned char	e_power;

#define INC_DELAY	10
#define S_DELAY		100
#define P_DELAY		500

#define PRESSED			1
#define NOT_PRESSED		0

unsigned char process_button( unsigned int hold, unsigned int state);
unsigned char check_button();

#define LED1	1
#define LED2	2
#define LED3	4
#define LED4	8

void mode_1();
void mode_2();				
void mode_3();
void mode_4();
void mode_5();
void mode_6();
void mode_7();				
void demo();	
void heart();
void binary();
void svetobobr();

unsigned char const_light( unsigned char sch,  unsigned char delay, unsigned char mask );

// somy service vars
rgb_pointer pack[PACK_SIZE];
rgb_pointer scheme[PACK_SIZE];

	rgb_pointer *pal;
	
int main(){
	
	mode = eeprom_read_byte(&e_mode);//Чтение
	s = eeprom_read_byte(&e_serie);//Чтение
	ss = eeprom_read_byte(&e_s_serie);//Чтение
	power = eeprom_read_byte(&e_power);//Чтение
	
	if (mode>MODE_NUM){
		mode=1;
	}
	
	if (s>S_NUM){
		s=1;
	}
	
	if (ss>1){
		ss=0;
	}
	
	if (power>1) {
		power=1;
	}
	
	DDRB=255;
	PORTB=0;
	
	for(;;){
		switch (mode){
			case 1:
				mode_1();
				break;;
			case 2:
				mode_2();
				break;;
			case 3:
				mode_3();
				break;;
		}
		
		switch (mode){
			case 4:
				mode_4();
				break;;
			case 5:
				mode_5();
				break;;
			case 6:
				mode_6();
				break;;
		}
		switch (mode){
			case 9:
				svetobobr();
				break;;		
			case 7:
				heart();
				break;;	
			case 8:
				binary();
				break;;							
			case 10:
				demo();
				break;;
		}
		
		if (ss==1){
			if ( ++s > S_NUM ){
				s=1;
			} 	
		}
		
		 if (power==1){
			 pal=palette;
		 } else {
			 pal=h_palette;
		 }
	}
	
	return 0;
}

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask ){
	unsigned char i;
	for (i=0; i<n; i++){
		pack[i]= pal[0];
		if ( (i<8) && ( (mask&(1<<i))==(1<<i) ) ) pack[i]=color;
	}
}


void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  ){
	unsigned char i;
	for (i=0; i<n; i++){
		pack[i]= pal[0];
		if ( (i<8) && ( (mask&(1<<i))==(1<<i) ) ) pack[i]=color[i];
	}	
}




void mode_1(){
	const_light(s, 10, LED1+LED2 + LED3+LED4 );
}

void mode_2(){
	const_light(s, 10, LED1+LED2 + LED3+LED4 );
	const_light(0, 10, LED1+LED2 + LED3+LED4 );
}

void mode_3(){
	const_light(s, 3, LED1 + 0 );
	const_light(s, 3, LED2 + 0 );
	const_light(s, 3, 0 + LED3 );
	const_light(s, 3, 0 + LED4 );
}

void mode_4(){
	const_light(s, 2, LED1+LED2 + LED3+LED4 );
	const_light(s, 3, LED1 + 0 );
	const_light(s, 3, LED2 + 0 );
	const_light(s, 3, 0 + LED3 );
	const_light(s, 3, 0 + LED4 );
	}

void mode_5(){
	const_light(s, 7, 0 + LED3+LED4 );
	const_light(s, 7, LED1+LED2 + 0 );
}

void mode_6(){
	const_light(s, 3, LED1+0 + 0+LED4 );
	const_light(s, 3, 0+LED2 + LED3+0 );
	const_light(s, 3, 0+0 +    LED3+0 );
	const_light(s, 3, 0+LED2 + LED3+0 );
	const_light(s, 3, LED1+0 + 0+LED4 );
}

void mode_7(){
	unsigned char i;
	for (i=0; i<20; i++){
		const_light(s, 3, LED1+0 + LED3+0 );
		const_light(s, 3, 0+LED2 + 0+LED4 );
	}
	for (i=0; i<2; i++){
		const_light(s, 30, 0+0 + 0+0 );
		const_light(s, 15, LED1+LED2 + LED3+LED4 );
		const_light(s, 30, 0+0 + 0+0 );
	}
}

void heart(){
	const_light(s, 3, 0 );
	const_light(s, 3, LED1+LED2 + 0+0 );
	const_light(s, 3, LED1+LED2 + LED3+0 );
	const_light(s, 3, 0+LED2 +   LED3+LED4 );
	const_light(s, 3, LED1+LED2 + LED3+0 );
	const_light(s, 3, LED1+LED2 + 0+0 );
	const_light(s, 3, 0 );
	
	const_light(s, 3, 0 );
	const_light(s, 2, 0+0 + LED3+LED4 );
	const_light(s, 3, 0+LED2 + LED3+LED4 );
	const_light(s, 3, LED1+LED2 + LED3+0 );
	const_light(s, 3, 0+LED2 + LED3+LED4 );
	const_light(s, 2, 0+0 + LED3+LED4 );
	const_light(s, 3, 0 );
}

void binary(){
	unsigned char i;
	for (i=1; i<10; i++){
		if (const_light(s, 3, i)>0) return;
	}
}

unsigned char check_button(){
	
	static unsigned int hold=0;
	static unsigned char button_state=NOT_PRESSED;
	static unsigned char last_button_state=NOT_PRESSED;
	
	unsigned char	st=BUTTON_PIN;
	unsigned char res=0;
	
	button_state=NOT_PRESSED;
	
	if ( ( (st &  (1<<BUTTON_1))  == (0<<BUTTON_1) ) ) {
		button_state = PRESSED;
	}
	
	if ( button_state == PRESSED ){
		hold++;
	}
	
	if ( last_button_state == button_state ){
		res = process_button( hold, button_state );
	}
	
	if ( button_state == NOT_PRESSED &&  last_button_state == NOT_PRESSED ){
		hold=0;
	}
	
	last_button_state=button_state;

	//res=button_state;
	return res;
}

unsigned char  const_light( unsigned char sch,  unsigned char delay, unsigned char mask ){
	unsigned char i;
			 
	for (i=0; i<delay; i++){
		if (sch<8){
			formColorPack(4, pal[sch], pack, mask);
			//if ( check_button()==1 ) return 1;
		} else {
			 // тут нужно забить цветовые схемы
	 		switch (sch){
				case 8:
					scheme[0]=pal[2];
					scheme[1]=pal[1];
					scheme[2]=pal[3];
					scheme[3]=pal[5];
					break;;
				case 9:
					scheme[0]=pal[1];
					scheme[1]=pal[1];
					scheme[2]=pal[3];
					scheme[3]=pal[3];
					break;;
				case 10:
					scheme[0]=pal[3];
					scheme[1]=pal[5];
					scheme[2]=pal[3];
					scheme[3]=pal[5];
					break;;
				case 11:
					scheme[0]=pal[1];
					scheme[1]=pal[1];
					scheme[2]=pal[5];
					scheme[3]=pal[5];
					break;;
			}
	 		switch (sch){
				case 12:
					scheme[0]=pal[5];
					scheme[1]=pal[1];
					scheme[2]=pal[5];
					scheme[3]=pal[1];
					break;;
				case 13:
					scheme[0]=pal[5];
					scheme[1]=pal[1];
					scheme[2]=pal[5];
					scheme[3]=pal[6];
					break;;
				case 14:
					scheme[0]=pal[3];
					scheme[1]=pal[2];
					scheme[2]=pal[3];
					scheme[3]=pal[2];
					break;;
				case 15:
					scheme[0]=pal[1];
					scheme[1]=pal[7];
					scheme[2]=pal[1];
					scheme[3]=pal[7];
					break;;
			}	
			formColorPack_scheme(4, scheme, pack, mask);
				
		}		
			
		if ( check_button()==1 ) return 1;	
		sendRGBpack(4, pack);	
	}
	
	return 0;
}

unsigned char process_button( unsigned int hold, unsigned int state){
	if ( hold > P_DELAY ){
		if ( state == NOT_PRESSED ){
			if (++power>1) power=0;
			eeprom_write_byte(&e_power, power);
			return 1;
		}
	} else if ( hold > S_DELAY ){	// next serie
		if ( state == NOT_PRESSED ){
			if ( ++mode > MODE_NUM ) { 
				mode=1; 
			}
			
			eeprom_write_byte(&e_mode,   mode);//Запись

			return 1;
		}		
	}  else if ( hold > INC_DELAY ){	// next mode
		if ( state == NOT_PRESSED ){
			if (ss==1){
				ss=0;
				s=1;
			} else 	if ( ++s > S_NUM ){
				s=1;
				ss=1;
			} 	
			
			eeprom_write_byte(&e_mode,   mode);//Запись
			eeprom_write_byte(&e_serie,   s);//Запись
			eeprom_write_byte(&e_s_serie,   ss);//Запись	
			
			return 1;
		}
		
	}
	
	return 0;
}


#define SP_L	2
#define	SB_L	1

void svetobobr(){
	const_light(s, SB_L, 0+LED2 + 0+LED4 );	//S
	const_light(s, SB_L, LED1+0 + LED3+0 );
	const_light(s, SP_L, 0+0 + 0+0 );
	
	const_light(s, SB_L, LED1+LED2 + LED3+0 );	//V
	const_light(s, SB_L, 0+0 + 0+LED4 );
	const_light(s, SB_L, LED1+LED2 + LED3+0 );
	const_light(s, SP_L, 0+0 + 0+0 );
	
	const_light(s, SB_L, LED1+LED2 + LED3+LED4 );	//e
	const_light(s, SB_L, LED1+LED2 + 0+LED4 );
	const_light(s, SP_L, 0+0 + 0+0 );
	
	const_light(s, SB_L, 0+0 + LED3+0 );			//t
	const_light(s, SB_L, LED1+LED2 + LED3+LED4 );
	const_light(s, SB_L, 0+0 + LED3+0 );
	const_light(s, SP_L, 0+0 + 0+0 );
	
	const_light(s, SB_L, 0+LED2 + LED3+0 );	//O
	const_light(s, SB_L, LED1+0 + 0+LED4 );
	const_light(s, SB_L, 0+LED2 + LED3+0 );
	const_light(s, SP_L, 0+0 + 0+0 );
	
	const_light(s, SB_L, LED1+LED2 + LED3+LED4 );	//b
	const_light(s, SB_L, 0+0 + LED3+LED4 );
	const_light(s, SP_L, 0+0 + 0+0 );
	
	const_light(s, SB_L, 0+LED2 + LED3+0 );	//O
	const_light(s, SB_L, LED1+0 + 0+LED4 );
	const_light(s, SB_L, 0+LED2 + LED3+0 );
	const_light(s, SP_L, 0+0 + 0+0 );
					
	const_light(s, SB_L, LED1+LED2 + LED3+LED4 ); 	//b
	const_light(s, SB_L, 0+0 + LED3+LED4 );
	const_light(s, SP_L, 0+0 + 0+0 );
	
	const_light(s, SB_L, LED1+LED2 + LED3+LED4 );	//r
	const_light(s, SB_L, LED1+0 + 0+0 );
	const_light(s, SP_L*2, 0+0 + 0+0 );
}









void demo(){
	static unsigned char mmm=1;
	static unsigned char nnn=1;
	//s=1;
	
	switch (mmm){
		case 1:
			mode_1();
			break;;
		case 2:
			mode_2();
			break;;
		case 3:
			mode_3();
			break;;	
	}
	
	switch (mmm){
		case 4:
			mode_4();
			break;;
		case 5:
			mode_5();
			break;;		
		case 6:
			mode_6();
			break;;	
	}
	
	nnn++;
	
	if (nnn>10){
		s++;
		nnn=1;
	}
	
	if (s>S_NUM){
		mmm++;
		s=1;
	}
	
	if (mmm>6){
		mmm=0;
	}
	
}
