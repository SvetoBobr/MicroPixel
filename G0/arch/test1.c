// t2313	attiny2313	24800 prog
// board	MMCU		programm_after_make
#define F_CPU 1000000UL
#include <avr/io.h>
#include <util/delay.h>

#define RED		(1+8)
#define GREEN	(2+16)
#define BLUE	(4+32)

#define LED1	7
#define LED2	(8+16+32)


#define BUTTON_PIN	PINA
#define BUTTON_1	0

unsigned char check_button();
#define PRESSED			1
#define NOT_PRESSED		0

int main(void){

	
	DDRA=0;
	DDRB=255;
	DDRD=255;
	
	PORTA=255;
	PORTB=255;
	PORTD=255;
	
	unsigned char a=0;
	
	while (1==1){
		if (a==1) {
			PORTB = 255;//(LED1 & GREEN) | (LED2 & RED);
			PORTD = 255;//(LED1 & GREEN) | (LED2 & BLUE);
		}
		//_delay_ms(300);
		else {	
			PORTD = (LED1 & RED) | (LED2 & RED);
			PORTB = (LED1 & RED) | (LED2 & RED);	
			//_delay_ms(300);
		
		}
		a=check_button();
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
		res = 1;
	}
	
	if ( button_state == NOT_PRESSED &&  last_button_state == NOT_PRESSED ){
		hold=0;
	}
	
	last_button_state=button_state;

	res=button_state;
	return res;
	
}
