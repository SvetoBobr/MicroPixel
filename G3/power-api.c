// 

#ifndef CSB_POWER_TOOLS_v1
#define CSB_POWER_TOOLS_v1

#include <avr/sleep.h>
#include <avr/interrupt.h>

unsigned char power;
#define ACTIVE	1
#define IDLE	0

inline void _set_active(){ power=ACTIVE; }
inline void _set_idle(){ power=IDLE; }

#define _interrupts_on() { GIMSK=1<<5; PCMSK=1<<4; sei(); }
#define _interrupts_off() { GIMSK=0; PCMSK=0; cli(); }

inline void go_sleep(){		// should be refactored
	set_sleep_mode(SLEEP_MODE_PWR_DOWN);
	sleep_enable();
	_interrupts_on();
	sleep_cpu();
	sleep_disable();
	//cli();	
}



#endif
