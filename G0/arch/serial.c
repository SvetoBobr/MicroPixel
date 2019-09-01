// t2313	attiny2313	38400 prog
// board	MMCU		programm_after_make
#define F_CPU 1000000UL
#include <avr/io.h>
#include <util/delay.h>

#define RED		(1+8)
#define GREEN	(2+16)
#define BLUE	(4+32)

#define LED1	(8+16+32)
#define LED2	7
#define LED3	(8+16+32)
#define LED4	7

//buttons
#define BUTTON_PIN	PINA
#define BUTTON_1	0

#define INC_DELAY	10
#define S_DELAY		100

#define PRESSED			1
#define NOT_PRESSED		0

//color schemes
#define S_BLACK		0
#define S_RED		1
#define S_YELLOW	2
#define S_GREEN		3
#define S_AQUA		4
#define S_BLUE		5
#define S_VIOLET	6
#define S_WHITE		7
#define S_GRAD_1	8
#define S_GRAD_2	9

//modes
#define MODE_NUM	8
#define S_NUM	15

unsigned char   up[16]={0,9,27,18,54,36,45,255, 0, 0, 0, 0, 0, 0, 0, 0};
unsigned char down[16]={0,9,27,18,54,36,45,255, 0, 0, 0, 0, 0, 0, 0, 0};

unsigned char mode;
unsigned char s;

unsigned char const_light( unsigned char sch,  unsigned char n, unsigned char l12, unsigned char l34 );

unsigned char process_button( unsigned int hold, unsigned int state);
unsigned char check_button();

void ogni();
void ogni2014();
void yarogni();
void svetobobr();
				
				
void mode_1();
void mode_2();				
void mode_3();
void mode_4();
void mode_5();
void mode_6();
				
void demo();			

int main(void){

	up[8]	= ( LED1 & (RED+GREEN) ) + ( LED2 & RED );
	down[8] = ( LED3 & (GREEN) ) + ( LED4 & BLUE );
	
	up[9]	= ( LED1 & (RED) ) + ( LED2 & RED );
	down[9] = ( LED3 & (GREEN) ) + ( LED4 & GREEN );

	up[10]	= ( LED1 & (BLUE) ) + ( LED2 & GREEN );
	down[10] = ( LED3 & (GREEN) ) + ( LED4 & BLUE );
	
	up[11]	= ( LED1 & (RED) ) + ( LED2 & RED );
	down[11] = ( LED3 & (BLUE) ) + ( LED4 & BLUE );	
	
	up[12]	= ( LED1 & (BLUE) ) + ( LED2 & RED );
	down[12] = ( LED3 & (BLUE) ) + ( LED4 & RED );	
	
	up[13]	= ( LED1 & (BLUE) ) + ( LED2 & RED );
	down[13] = ( LED3 & (BLUE) ) + ( LED4 & (BLUE+RED) );	
	
	up[14]	= ( LED1 & (GREEN) ) + ( LED2 & (RED+GREEN) );
	down[14] = ( LED3 & (GREEN) ) + ( LED4 & (RED+GREEN) );	
	
	up[15]	= ( LED1 & (RED) ) + ( LED2 & (RED+GREEN+BLUE) );
	down[15] = ( LED3 & (RED) ) + ( LED4 & (RED+GREEN+BLUE) );	
	
	DDRA=0;
	DDRB=255;
	DDRD=255;
	
	PORTA=255;
	PORTB=255;
	PORTD=255;
	
	mode=1;
	s=1;
	
	while (1==1){
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
			case 7:
				svetobobr();
				break;;
			case 8:
				demo();
				break;;
		}
		
		//_delay_ms(300);
	}
}

void mode_1(){
	const_light(s, 10, LED1+LED2, LED3+LED4 );
}

void mode_2(){
	const_light(s, 10, LED1+LED2, LED3+LED4 );
	const_light(0, 10, LED1+LED2, LED3+LED4 );
}

void mode_3(){
	const_light(s, 3, LED1, 0 );
	const_light(s, 3, LED2, 0 );
	const_light(s, 3, 0, LED3 );
	const_light(s, 3, 0, LED4 );
}

void mode_4(){
	const_light(s, 2, LED1+LED2, LED3+LED4 );
	const_light(s, 3, LED1, 0 );
	const_light(s, 3, LED2, 0 );
	const_light(s, 3, 0, LED3 );
	const_light(s, 3, 0, LED4 );
	}

void mode_5(){
	const_light(s, 7, 0, LED3+LED4 );
	const_light(s, 7, LED1+LED2, 0 );
}

void mode_6(){
	const_light(s, 3, LED1+0, 0+LED4 );
	const_light(s, 3, 0+LED2, LED3+0 );
	const_light(s, 3, 0+0,    LED3+0 );
	const_light(s, 3, 0+LED2, LED3+0 );
	const_light(s, 3, LED1+0, 0+LED4 );
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

unsigned char  const_light( unsigned char sch,  unsigned char n, unsigned char l12, unsigned char l34 ){
	unsigned char i, c;
	
	for (i=0; i<n; i++){
		PORTD=up[sch] & l12;
		PORTB=down[sch] & l34;
	
		_delay_ms(3);
		
		c=check_button();
		if (c>0) return c;
	}
	
	return 0;
}




unsigned char process_button( unsigned int hold, unsigned int state){
	
	if ( hold > S_DELAY ){	// next serie
		if ( state == NOT_PRESSED ){
			if ( ++mode > MODE_NUM ) { 
				mode=1; 
			}
			return 1;
		}		
	}  else if ( hold > INC_DELAY ){	// next mode
		if ( state == NOT_PRESSED ){
			if ( ++s > S_NUM ){
				s=1;
			} 		
			return 1;
		}
		
	}
	
	return 0;
}


#define SP_L	2
#define	SB_L	1

void svetobobr(){
	const_light(s, SB_L, 0+LED2, 0+LED4 );	//S
	const_light(s, SB_L, LED1+0, LED3+0 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+0 );	//V
	const_light(s, SB_L, 0+0, 0+LED4 );
	const_light(s, SB_L, LED1+LED2, LED3+0 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//e
	const_light(s, SB_L, LED1+LED2, 0+LED4 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, 0+0, LED3+0 );			//t
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );
	const_light(s, SB_L, 0+0, LED3+0 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, 0+LED2, LED3+0 );	//O
	const_light(s, SB_L, LED1+0, 0+LED4 );
	const_light(s, SB_L, 0+LED2, LED3+0 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//b
	const_light(s, SB_L, 0+0, LED3+LED4 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, 0+LED2, LED3+0 );	//O
	const_light(s, SB_L, LED1+0, 0+LED4 );
	const_light(s, SB_L, 0+LED2, LED3+0 );
	const_light(s, SP_L, 0+0, 0+0 );
					
	const_light(s, SB_L, LED1+LED2, LED3+LED4 ); 	//b
	const_light(s, SB_L, 0+0, LED3+LED4 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//r
	const_light(s, SB_L, LED1+0, 0+0 );
	const_light(s, SP_L*2, 0+0, 0+0 );
}

void ogni2014(){
	ogni();
	
	const_light(s, SB_L, LED1+0, 0+LED4 );			//2
	const_light(s, SB_L, LED1+0, LED3+LED4 );	
	const_light(s, SB_L, LED1+LED2, 0+LED4 );	
	const_light(s, SP_L, 0+0, 0+0 );		
	
	const_light(s, SB_L, 0+LED2, LED3+0 );	//O
	const_light(s, SB_L, LED1+0, 0+LED4 );
	const_light(s, SB_L, 0+LED2, LED3+0 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//1
	const_light(s, SP_L, 0+0, 0+0 );	
	
	const_light(s, SB_L, LED1+LED2, LED3+0 );	//4
	const_light(s, SB_L, 0+0, LED3+0 );	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	
	const_light(s, SP_L*2, 0+0, 0+0 );	
}

void yarogni(){
	const_light(s, SB_L, LED1+0, 0+0 );				//Y
	const_light(s, SB_L, 0+LED2, LED3+LED4 );
	const_light(s, SB_L, LED1+0, 0+0 );
	const_light(s, SP_L, 0+0, 0+0 );

	const_light(s, SB_L, 0+LED2, LED3+LED4 );		//A
	const_light(s, SB_L, LED1+0, LED3+0 );
	const_light(s, SB_L, 0+LED2, LED3+LED4 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//r
	const_light(s, SB_L, LED1+0, 0+0 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//I
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//e
	const_light(s, SB_L, LED1+LED2, 0+LED4 );
	const_light(s, SP_L*2, 0+0, 0+0 );
	
	ogni();
}

void ogni(){
	const_light(s, SB_L, 0+LED2, LED3+0 );	//O
	const_light(s, SB_L, LED1+0, 0+LED4 );
	const_light(s, SB_L, 0+LED2, LED3+0 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//G
	const_light(s, SB_L, LED1+0, 0+LED4 );
	const_light(s, SB_L, LED1+0, LED3+LED4 );
	const_light(s, SP_L, 0+0, 0+0 );
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//N
	const_light(s, SB_L, 0+LED2, 0+0 );	
	const_light(s, SB_L, 0+0, LED3+0 );	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	
	const_light(s, SP_L, 0+0, 0+0 );		
	
	const_light(s, SB_L, LED1+LED2, LED3+LED4 );	//I
	const_light(s, SP_L*2, 0+0, 0+0 );	
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




