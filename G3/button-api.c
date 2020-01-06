// micropixel button control

#ifndef MPX_G3_BUTTON_API_V1

#define MPX_G3_BUTTON_API_V1

#define PRESSED			1
#define NOT_PRESSED		0

#include <avr/interrupt.h>


#include "./signals.h"

inline unsigned char process_button( unsigned int hold, unsigned int state);
unsigned char check_button();

#ifndef MODE_NUM	
	#error "no mode number"
#endif

unsigned char stat;

// power options
#ifdef SOFTWARE_SLEEP
	#include "./power-api.c"
#endif

extern void reset_timer();

ISR(PCINT0_vect){
	cli();
	
	check_all();
	init_io();
	
	unsigned char	st=BUTTON_PIN;
	unsigned char	counter=0;
	// надо как-то переложить функции этой херни на process_button(), а обработку состояний делать в основном цикле
	while ( ( (st &  (1<<MODE_BUTTON))  == (0<<MODE_BUTTON) ) ) {
		st=BUTTON_PIN;
		_delay_ms(2);
		
		if (++counter>WAKE_THRESHOLD){
			_set_active();
			stat=SIGNAL_AWAKEN;
			return;
		}
	}
	
	_delay_ms(5);
	_set_idle();
	//_interrupts_off();
	return;
}

unsigned char check_button(){
	
	static unsigned int hold=0;
	static unsigned char button_state=NOT_PRESSED;
	static unsigned char last_button_state=NOT_PRESSED;
	
	unsigned char	st=BUTTON_PIN;
	unsigned char res=0;
	
	button_state=NOT_PRESSED;
	
	if ( ( (st &  (1<<MODE_BUTTON))  == (0<<MODE_BUTTON) ) ) {
		button_state = PRESSED;
	}
	
	if ( button_state == PRESSED ){
		hold++;
	}
	
	if ( last_button_state == button_state ){
		res = process_button( hold, button_state );
		reset_timer();	// reset watchdog
	}
	
	if ( button_state == NOT_PRESSED &&  last_button_state == NOT_PRESSED ){
		hold=0;
	}
	
	last_button_state=button_state;
	return res;
}


//----------------------------------------------------------------------------
unsigned char process_button( unsigned int hold, unsigned int state){
	#ifdef CLEAR_DELAY
	if ( hold > CLEAR_DELAY ){	// // CLEAR favorite
		stat=SIGNAL_CLEAR;
		if ( state == NOT_PRESSED ){
			pointer=0;
			counter=0;
			fav_on=0;
	
			check_all();
			store_data();	//Запись
			stat=0;
			return 1;
		}
	}  else 
	#endif 
	#ifdef T_FAV_DELAY
	if ( hold > T_FAV_DELAY ){	// // TOGGLE to/from favorite
		stat=SIGNAL_TO_FAV;
		if ( state == NOT_PRESSED ){
			// toggle to/from favorite
			if (fav_on==0){
				fav_on=1;
				pointer=1;
			} else {
				fav_on=0;
			}	
			
			check_all();
			store_data();	//Запись
			stat=0;
			return 1;
		}		
	}  else 
	#endif
	
	#ifdef W_FAV_DELAY
	if ( hold > W_FAV_DELAY ){	// //	WRITE mode to favorite
		if (fav_on==0 && counter<FAV_MAX){
			stat=SIGNAL_WRITE_FAV;
			if ( state == NOT_PRESSED ){	//	write mode to favorite
				if (counter<FAV_MAX) {
					counter++;
					modes[counter]=mode;
					series[counter]=serie;
				} 
				
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}		
		} 
	}  else 
	#endif
	
	#ifdef HALT_DELAY
	if ( hold > HALT_DELAY ){ // software HALT
		stat=SIGNAL_HALT;
		if ( state == NOT_PRESSED ){
			_set_idle();
			store_data();	//Запись
			stat=0;
			return 1;
		}
	} else 
	#endif

	#ifdef ECONOM_ENABLED
	if ( hold > ECONOM_DELAY ){ // economy mode
		stat=SIGNAL_ECONOM;
		if ( state == NOT_PRESSED ){
			if (++econom>3) econom=0;
	
			store_data();	//Запись
			stat=0;
			return 1;
		}
	} else 
	#endif
	
	if ( hold > S_DELAY ){	// next SERIE
		#ifdef USE_FAV
			if (fav_on==0){
				stat=SIGNAL_NEXT_SERIE;
					if ( state == NOT_PRESSED && fav_on==0 ){
						if (++serie>S_NUM){
							serie=1;
						} 		
						#ifdef RESET_MODE_ON_SERIE	
							mode=1;
						#endif
						store_data();	//Запись
						stat=0;
						return 1;
					}	
			}	
		#else
			stat=SIGNAL_NEXT_SERIE;
			if ( state == NOT_PRESSED){
				if (++serie>S_NUM){
					serie=1;
				} 			
				#ifdef RESET_MODE_ON_SERIE
					mode=1;
				#endif
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}	
		#endif
		
	}  else if ( hold > INC_DELAY ){	// next MODE
		if ( state == NOT_PRESSED ){
			#ifdef USE_FAV
			if ( fav_on==0 ) {
				if (++mode>MODE_NUM) { 
					mode=1; 
				}
			} else {
				if (++pointer>counter) { 
					pointer=1; 
				}
			}
			#else 
				if (++mode>MODE_NUM) { 
					mode=1; 
				}
			#endif
			
			check_all();
			store_data();	//Запись
			return 1;
		}
	}
	
	return 0;
}

#endif
