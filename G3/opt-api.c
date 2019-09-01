// some useful functions

#ifndef CSB_OPT_API_v1
#define CSB_OPT_API_v1

#define MICROPIXEL	1
#define RGB_PROP	2
//signaling API

#include "./signals.h"

#if PROP_TYPE==MICROPIXEL
	void process_signal(unsigned char signal){
		startFrame();
		
		switch (signal){
		case SIGNAL_NEXT_SERIE:
			sendRGB(0,0,10);
			sendRGB(0,0,10);
			sendRGB(0,0,10);
			sendRGB(0,0,10);
			break;
		case SIGNAL_HALT:
			sendRGB(7,7,0);
			sendRGB(7,7,0);
			sendRGB(7,7,0);
			sendRGB(7,7,0);
			break;
		case SIGNAL_ECONOM:
			sendRGB(10,0,0);
			sendRGB(0,10,0);
			sendRGB(10,0,0);
			sendRGB(0,10,0);
			break;	
		case SIGNAL_WRITE_FAV:
			sendRGB(0,10,0);
			sendRGB(0,10,0);
			sendRGB(0,10,0);
			sendRGB(0,10,0);
			break;	
		case SIGNAL_CLEAR:
			sendRGB(4,4,4);
			sendRGB(4,4,4);
			sendRGB(4,4,4);
			sendRGB(4,4,4);
			break;		
		case SIGNAL_TO_FAV:
			sendRGB(10,0,0);
			sendRGB(10,0,0);
			sendRGB(10,0,0);
			sendRGB(10,0,0);
			break;		
		case SIGNAL_AWAKEN:
			sendRGB(10,0,0);
			sendRGB(0,10,0);
			sendRGB(0,10,0);
			sendRGB(0,0,10);
			_delay_ms(200);
			stat=0;
			break;
		default:
			break;
		}
		
	//	endFrame();
		check_button();

	}
#elif PROP_TYPE==RGB_PROP
	#warning	"NOT COMMITED YET"
#else
	#warning	"NO PROP TYPE DEFINED"
#endif

#endif
