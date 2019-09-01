// t45	attiny45	76800 prog
// board	MMCU		programm_after_make
//38400


#define F_CPU 8000000
#define CPU_TYPE	 T45

#define FRAME_DELAY 1.5
#define MAX_LEVEL	255
#define HALF_LEVEL	60
#define PACK_SIZE	10

#define BOARD GDCV
#include "../../boards.h"

//#define PORT_MASK	((1<<BUTTON_1)+(1<<GND_PIN))

#include "../apa102-driver.c"

#include <avr/io.h>

#include <util/delay.h>

#include "../palette_7.c"

#include <avr/eeprom.h>

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );

//modes
#define MODE_NUM	14
#define S_NUM	11

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

#define LED_NUM	8

#define LED1	1
#define LED2	2
#define LED3	4
#define LED4	8
#define LED5	16
#define LED6	32
#define LED7	64
#define LED8	128

void mode_1();
void mode_2();				
void mode_3();
void mode_4();
void mode_5();
void mode_6();
void mode_7();			
void mode_8();
void mode_9();			
void mode_10();					
void demo();	
void heart();
void binary();
void svetobobr();

unsigned char const_light( unsigned char sch,  unsigned char delay, unsigned char mask );

// somy service vars
rgb_pointer pack[PACK_SIZE];
rgb_pointer scheme[PACK_SIZE];

	rgb_pointer *pal;
	
unsigned char bbb=0;

void make_serie(unsigned char sss){
	switch (sss){
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
		
		switch (sss){
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
		switch (sss){
			case 7:
				mode_7();
				break;;		
			case 8:
				mode_8();
				break;;	
			case 9:
				mode_9();
				break;;							
			case 10:
				mode_10();
				break;;
		}
		switch (sss){
			case 13:
				svetobobr();
				break;;		
			case 11:
				heart();
				break;;	
			case 12:
				binary();
				break;;							
			case 14:
				demo();
				break;;
		}
	
}

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
		bbb=0;
		
		make_serie(mode);
		
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




void mode_1(){	// constd
	const_light(s, 10, 255 );
}

void mode_2(){	// strob
	const_light(s, 6, 255 );
	const_light(0, 6, 255 );
}

void mode_3(){	// gears
	const_light(s, 6, 1+2+4+8 );
	const_light(s, 6, 255-(1+2+4+8) );
}

void mode_4(){	// flower
	const_light(s, 3, LED1 );
	const_light(s, 3, LED2 );
	const_light(s, 3, LED3 );
	const_light(s, 3, LED4 );
	const_light(s, 3, LED5 );
	const_light(s, 3, LED6 );
	const_light(s, 3, LED7 );
	const_light(s, 2, 255 );
}

void mode_5(){	// romb 1
	const_light(0, 3, 0 );
	const_light(s, 3, LED4+LED5 + 0 );
	const_light(s, 3, LED3+LED6 + 0 );
	const_light(s, 3, LED3+LED6 + LED2+LED7 );
	const_light(s, 6, LED1+LED8 + LED4+LED5 );
	const_light(s, 3, LED3+LED6 + LED2+LED7 );
	const_light(s, 3, LED3+LED6 + 0 );
	const_light(s, 3, LED4+LED5 + 0 );
}

void mode_6(){	// chain
	const_light(s, 12, LED3 + LED4 + LED5 + LED6 );
	const_light(s, 3, 0 + LED4 + LED5 + 0 );
	const_light(s, 3, LED2 + LED3 + LED4 + LED5 + LED6 + LED7 );
	const_light(s, 3, LED1 + LED2 + LED3 + LED6 + LED7 + LED8 );
	const_light(s, 9, LED1 + LED2 + LED7 + LED8 );
	const_light(s, 3, LED1 + LED2 + LED3 + LED6 + LED7 + LED8 );
	const_light(s, 3, LED2 + LED3 + LED4 + LED5 + LED6 + LED7 );
	const_light(s, 3, 0 + LED4 + LED5 + 0 );
}

void mode_7(){	//flash (molnia)
	const_light(s, 3, LED2 );
	const_light(s, 3, LED1 + 0 + 0 + 0 + 0 + 0 );
	const_light(s, 3, LED2 + LED3 + LED8 );
	const_light(s, 3, 0 + 0 + LED4 + 0 + 0 + LED7 );
	const_light(s, 9, LED2 + LED3 + LED4 + LED5 + LED6 + LED7 );
	const_light(s, 3, 0 + LED3 + 0 + LED5 + 0 + 0 );
	const_light(s, 3, 0 + LED3 + 0 + LED5 + LED6 + 0 );
	const_light(s, 3, LED2 + LED7 );
	const_light(s, 6, LED1 + LED6  );
	const_light(s, 3, LED2 + LED6 );
	const_light(s, 3, LED2 + LED5 + 0 + LED7 );
	const_light(s, 3, LED3 + LED4 + LED7 );
	const_light(s, 3, LED3 + LED8 );
	const_light(s, 3, LED4 + LED7 );
	const_light(s, 3, LED3 + LED4 + LED8 );
	const_light(s, 3, LED2 + LED8 );
	const_light(s, 3, LED2  );
}

void mode_8(){	//fire-flower
	const_light(s, 3, 0 );
	const_light(s, 3, LED6 + LED7 );
	const_light(s, 3, LED6 + LED7 + LED3 + LED4 + LED5);
	const_light(s, 3, 0 + LED2 + LED3 + LED4 + LED5);
	const_light(s, 3, LED1 + LED2 + LED3 + LED4 + LED5 + LED6 + 0 );
	const_light(s, 3, LED1 + LED2 + LED3 + LED4 + LED5 + LED6 + LED7 + LED8);
	const_light(s, 3, LED1 + LED2 + LED3 + LED4 + LED5 + LED6 + 0 );
	const_light(s, 3, 0 + LED2 + LED3 + LED4 + LED5);
	const_light(s, 3, LED6 + LED7 + LED3 + LED4 + LED5);
	const_light(s, 3, LED6 + LED7 );
}

void mode_9(){	// 
	const_light(s, 6, 0 );
	const_light(s, 6, LED6 + LED7 + LED8 );
	const_light(s, 3, LED6 + LED7 + LED8 + LED3);
	const_light(s, 6, LED4 + LED5 );
	const_light(s, 3, LED1 + LED2 + LED3 + LED6);
	const_light(s, 6, LED1 + LED2 + LED3 );
}

void mode_10(){	//	? !
	const_light(s, 3, 0 );
	const_light(s, 3, LED6 + LED7 );
	const_light(s, 3,  LED8 );
	const_light(s, 3, LED1 + LED3 + LED4 + 0 + LED8 );
	const_light(s, 3, LED5 + LED8 );
	const_light(s, 3, LED6 + LED7 );
	const_light(s, 3, 0 );
	const_light(s, 3, 255 - 2 );
	
}

		
void heart(){
	const_light(s, 3, 0 );
	const_light(s, 3, LED5 + LED6 + LED7);
	const_light(s, 3, LED5 + LED6 + LED7 + LED4 + LED8);
	const_light(s, 3, LED5 + LED6 + LED7 + LED4 + LED8 + LED3);
	const_light(s, 3, 126 );
	const_light(s, 3, 1+2+4+8 );
	const_light(s, 3, 126 );
	const_light(s, 3, LED5 + LED6 + LED7 + LED4 + LED8 + LED3);
	const_light(s, 3, LED5 + LED6 + LED7 + LED4 + LED8);
	const_light(s, 3, LED5 + LED6 + LED7);
	
}

void binary(){
	static unsigned char i=0;
	const_light(s, 3, i++);
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
	
	unsigned char i, j;
			 
	if (bbb==1) return 1;
	
	for (i=0; i<delay; i++){
		if (sch<8){
			formColorPack(LED_NUM, pal[sch], pack, mask);
			//if ( check_button()==1 ) return 1;
		} else {
			 // тут нужно забить цветовые схемы
	 		switch (sch){
				case 8:
					scheme[0]=pal[7];
					for (j=1; j<8; j++)
						scheme[j]=pal[j];
					break;;
				case 9:
					scheme[0]=pal[1];
					scheme[1]=pal[1];
					scheme[2]=pal[1];
					scheme[3]=pal[5];
					
					scheme[4]=pal[5];
					scheme[5]=pal[7];
					scheme[6]=pal[7];
					scheme[7]=pal[7];
					break;;
				case 10:
					scheme[0]=pal[1];
					scheme[1]=pal[1];
					scheme[2]=pal[1];
					scheme[3]=pal[1];
					
					scheme[4]=pal[3];
					scheme[5]=pal[3];
					scheme[6]=pal[3];
					scheme[7]=pal[3];
					break;;
				case 11:
					scheme[0]=pal[1];
					scheme[1]=pal[3];
					scheme[2]=pal[1];
					scheme[3]=pal[5];
					
					scheme[4]=pal[1];
					scheme[5]=pal[3];
					scheme[6]=pal[1];
					scheme[7]=pal[5];
					break;;
			}

			formColorPack_scheme(LED_NUM, scheme, pack, mask);
				
		}		
			
		if ( check_button()==1 ) {
			bbb=1;
			return 1;	
		}
		sendRGBpack(LED_NUM, pack);	
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
	const_light(s, 1, LED5+LED6 );	//S
	const_light(s, 2, LED1+LED4+LED7 );
	const_light(s, 1, LED2+LED3 );	
	
	const_light(s, 2, 0+0 + 0+0 );	// pause
	
	const_light(s, 1, LED5+LED6+LED7 );	//V
	const_light(s, 1, LED3+LED4 );
	const_light(s, 1, LED1+LED2 );
	const_light(s, 1, LED3+LED4 );
	const_light(s, 1, LED5+LED6+LED7 );
	
	const_light(s, 2, 0+0 + 0+0 ); // pause
	
	const_light(s, 1, 127 );	//e
	const_light(s, 3, LED1+LED7 + 0+LED4 );
	
	const_light(s, 2, 0+0 + 0+0 );	// pause
	
	const_light(s, 2, 0+0 + LED7+0 );			//t
	const_light(s, 1, 127 );
	const_light(s, 2, 0+0 + LED7+0 );
	
	const_light(s, 2, 0+0 + 0+0 ); // pause
	
	const_light(s, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );	//O
	const_light(s, 2, LED1+0 + 0+LED7 );
	const_light(s, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );
	
	const_light(s, 2, 0+0 + 0+0 ); // pause
	
	const_light(s, 1, 127 );	//b
	const_light(s, 2, LED1+LED7 + 0+LED4 );
	const_light(s, 1, LED2+LED3 + LED5+LED6 );
	
	const_light(s, 2, 0+0 + 0+0 ); // pause
	
	const_light(s, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );	//O
	const_light(s, 2, LED1+0 + 0+LED7 );
	const_light(s, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );
	
	const_light(s, 2, 0+0 + 0+0 );	// pause
					
	const_light(s, 1, 127 );	//b
	const_light(s, 2, LED1+LED7 + 0+LED4 );
	const_light(s, 1, LED2+LED3 + LED5+LED6 );
	
	const_light(s, 2, 0+0 + 0+0 );	// pause
	
	const_light(s, 1, 127 );	//r
	const_light(s, 1, LED4+LED7 );
	const_light(s, 1, LED3+LED7 );
	const_light(s, 1, LED1+LED2+LED5+LED6 );
	
	const_light(s, 5, 0+0 + 0+0 );	// big pause
}









void demo(){
	static unsigned char mmm=1;
	static unsigned char nnn=1;
	//s=1;
	
	make_serie(mmm);
	nnn++;
	
	if (nnn>10){
		s++;
		nnn=1;
	}
	
	if (s>S_NUM){
		mmm++;
		s=1;
	}
	
	if (mmm>=MODE_NUM){
		mmm=0;
	}
	
}
