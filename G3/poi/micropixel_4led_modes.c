

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
				mode_4_18();
				//svetobobr();
				break;;		
			case 11:
				heart();
				break;;	
			case 12:
				binary();
				break;;							
			case 14:
				mode_8_18();
				//demo();
				break;;
		}
		switch (sss){
			case 15: 
				svetobobr();
				break;;
			case 16:
				demo();
				break;;
			case 17:
				demo_long();
				break;
		}
	
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


void const_light_legacy(unsigned char mode, unsigned char t, unsigned char ledmask){
	flush_mask();
	if ( (ledmask & 1) == 1) mask[1]=1;
	if ( (ledmask & 2) == 2) mask[2]=1;
	if ( (ledmask & 4) == 4) mask[3]=1;
	if ( (ledmask & 8) == 8) mask[4]=1;
	
	const_light(mode, t);
}

void mode_1(){	// constd
	const_light_legacy(mode, 10, 255 );
}

void mode_2(){	// strob
	const_light_legacy(mode, 6, 255 );
	const_light_legacy(0, 6, 255 );
}

void mode_3(){	// gears
	const_light_legacy(mode, 6, 1+2+4+8 );
	const_light_legacy(mode, 6, 255-(1+2+4+8) );
}

void mode_4(){	// flower
	const_light_legacy(mode, 3, LED1 );
	const_light_legacy(mode, 3, LED2 );
	const_light_legacy(mode, 3, LED3 );
	const_light_legacy(mode, 3, LED4 );
	const_light_legacy(mode, 3, LED5 );
	const_light_legacy(mode, 3, LED6 );
	const_light_legacy(mode, 3, LED7 );
	const_light_legacy(mode, 2, 255 );
}

void mode_4_18(){	// not really flower from mpx 18
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i==1 || i==LED_NUM-a || i==1 || i==LED_NUM) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 1 );
	if (++a>LED_NUM) a=0;
}

void mode_5(){	// romb 1
	const_light_legacy(0, 3, 0 );
	const_light_legacy(mode, 3, LED4+LED5 + 0 );
	const_light_legacy(mode, 3, LED3+LED6 + 0 );
	const_light_legacy(mode, 3, LED3+LED6 + LED2+LED7 );
	const_light_legacy(mode, 6, LED1+LED8 + LED4+LED5 );
	const_light_legacy(mode, 3, LED3+LED6 + LED2+LED7 );
	const_light_legacy(mode, 3, LED3+LED6 + 0 );
	const_light_legacy(mode, 3, LED4+LED5 + 0 );
}

void mode_6(){	// chain
	const_light_legacy(mode, 11, LED3 + LED4 + LED5 + LED6 );
	const_light_legacy(mode, 3, 0 + LED4 + LED5 + 0 );
	const_light_legacy(mode, 3, LED2 + LED3 + LED4 + LED5 + LED6 + LED7 );
	const_light_legacy(mode, 3, LED1 + LED2 + LED3 + LED6 + LED7 + LED8 );
	const_light_legacy(mode, 9, LED1 + LED2 + LED7 + LED8 );
	const_light_legacy(mode, 3, LED1 + LED2 + LED3 + LED6 + LED7 + LED8 );
	const_light_legacy(mode, 3, LED2 + LED3 + LED4 + LED5 + LED6 + LED7 );
	const_light_legacy(mode, 3, 0 + LED4 + LED5 + 0 );
}

void mode_7(){	//flash (molnia)
	const_light_legacy(mode, 3, LED2 );
	const_light_legacy(mode, 3, LED1 + 0 + 0 + 0 + 0 + 0 );
	const_light_legacy(mode, 3, LED2 + LED3 + LED8 );
	const_light_legacy(mode, 3, 0 + 0 + LED4 + 0 + 0 + LED7 );
	const_light_legacy(mode, 9, LED2 + LED3 + LED4 + LED5 + LED6 + LED7 );
	const_light_legacy(mode, 3, 0 + LED3 + 0 + LED5 + 0 + 0 );
	const_light_legacy(mode, 3, 0 + LED3 + 0 + LED5 + LED6 + 0 );
	const_light_legacy(mode, 3, LED2 + LED7 );
	const_light_legacy(mode, 6, LED1 + LED6  );
	const_light_legacy(mode, 3, LED2 + LED6 );
	const_light_legacy(mode, 3, LED2 + LED5 + 0 + LED7 );
	const_light_legacy(mode, 3, LED3 + LED4 + LED7 );
	const_light_legacy(mode, 3, LED3 + LED8 );
	const_light_legacy(mode, 3, LED4 + LED7 );
	const_light_legacy(mode, 3, LED3 + LED4 + LED8 );
	const_light_legacy(mode, 3, LED2 + LED8 );
	const_light_legacy(mode, 3, LED2  );
}

void mode_8(){	//fire-flower
	const_light_legacy(mode, 3, 0 );
	const_light_legacy(mode, 3, LED6 + LED7 );
	const_light_legacy(mode, 3, LED6 + LED7 + LED3 + LED4 + LED5);
	const_light_legacy(mode, 3, 0 + LED2 + LED3 + LED4 + LED5);
	const_light_legacy(mode, 3, LED1 + LED2 + LED3 + LED4 + LED5 + LED6 + 0 );
	const_light_legacy(mode, 3, LED1 + LED2 + LED3 + LED4 + LED5 + LED6 + LED7 + LED8);
	const_light_legacy(mode, 3, LED1 + LED2 + LED3 + LED4 + LED5 + LED6 + 0 );
	const_light_legacy(mode, 3, 0 + LED2 + LED3 + LED4 + LED5);
	const_light_legacy(mode, 3, LED6 + LED7 + LED3 + LED4 + LED5);
	const_light_legacy(mode, 3, LED6 + LED7 );
}

void mode_8_18(){ // cool 
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( (((i+a) & 2)>0) || (i==1) || (i==LED_NUM) ) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 1 );
	a++;
	if (a>LED_NUM) a=0;
}

void mode_9(){	// 
	const_light_legacy(mode, 6, 0 );
	const_light_legacy(mode, 6, LED6 + LED7 + LED8 );
	const_light_legacy(mode, 3, LED6 + LED7 + LED8 + LED3);
	const_light_legacy(mode, 6, LED4 + LED5 );
	const_light_legacy(mode, 3, LED1 + LED2 + LED3 + LED6);
	const_light_legacy(mode, 6, LED1 + LED2 + LED3 );
}

void mode_10(){	//	? !
	const_light_legacy(mode, 3, 0 );
	const_light_legacy(mode, 3, LED6 + LED7 );
	const_light_legacy(mode, 3,  LED8 );
	const_light_legacy(mode, 3, LED1 + LED3 + LED4 + 0 + LED8 );
	const_light_legacy(mode, 3, LED5 + LED8 );
	const_light_legacy(mode, 3, LED6 + LED7 );
	const_light_legacy(mode, 3, 0 );
	const_light_legacy(mode, 3, 255 - 2 );
	
}

		
void heart(){
	const_light_legacy(mode, 3, 0 );
	const_light_legacy(mode, 3, LED5 + LED6 + LED7);
	const_light_legacy(mode, 3, LED5 + LED6 + LED7 + LED4 + LED8);
	const_light_legacy(mode, 3, LED5 + LED6 + LED7 + LED4 + LED8 + LED3);
	const_light_legacy(mode, 3, 126 );
	const_light_legacy(mode, 3, 1+2+4+8 );
	const_light_legacy(mode, 3, 126 );
	const_light_legacy(mode, 3, LED5 + LED6 + LED7 + LED4 + LED8 + LED3);
	const_light_legacy(mode, 3, LED5 + LED6 + LED7 + LED4 + LED8);
	const_light_legacy(mode, 3, LED5 + LED6 + LED7);
	
}

void binary(){
	static unsigned char i=0;
	static char a=1;
	const_light_legacy(mode, 3, i+=a);
	if (i==255) a=-1;;
	if (i==0) a=1;
}

#define SP_L	2
#define	SB_L	1

void svetobobr(){
	const_light_legacy(mode, 1, LED5+LED6 );	//S
	const_light_legacy(mode, 2, LED1+LED4+LED7 );
	const_light_legacy(mode, 1, LED2+LED3 );	
	
	const_light_legacy(mode, 2, 0+0 + 0+0 );	// pause
	
	const_light_legacy(mode, 1, LED5+LED6+LED7 );	//V
	const_light_legacy(mode, 1, LED3+LED4 );
	const_light_legacy(mode, 1, LED1+LED2 );
	const_light_legacy(mode, 1, LED3+LED4 );
	const_light_legacy(mode, 1, LED5+LED6+LED7 );
	
	const_light_legacy(mode, 2, 0+0 + 0+0 ); // pause
	
	const_light_legacy(mode, 1, 127 );	//e
	const_light_legacy(mode, 3, LED1+LED7 + 0+LED4 );
	
	const_light_legacy(mode, 2, 0+0 + 0+0 );	// pause
	
	const_light_legacy(mode, 2, 0+0 + LED7+0 );			//t
	const_light_legacy(mode, 1, 127 );
	const_light_legacy(mode, 2, 0+0 + LED7+0 );
	
	const_light_legacy(mode, 2, 0+0 + 0+0 ); // pause
	
	const_light_legacy(mode, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );	//O
	const_light_legacy(mode, 2, LED1+0 + 0+LED7 );
	const_light_legacy(mode, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );
	
	const_light_legacy(mode, 2, 0+0 + 0+0 ); // pause
	
	const_light_legacy(mode, 1, 127 );	//b
	const_light_legacy(mode, 2, LED1+LED7 + 0+LED4 );
	const_light_legacy(mode, 1, LED2+LED3 + LED5+LED6 );
	
	const_light_legacy(mode, 2, 0+0 + 0+0 ); // pause
	
	const_light_legacy(mode, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );	//O
	const_light_legacy(mode, 2, LED1+0 + 0+LED7 );
	const_light_legacy(mode, 1, 0+LED2 + LED3+ LED4+LED5+LED6 );
	
	const_light_legacy(mode, 2, 0+0 + 0+0 );	// pause
					
	const_light_legacy(mode, 1, 127 );	//b
	const_light_legacy(mode, 2, LED1+LED7 + 0+LED4 );
	const_light_legacy(mode, 1, LED2+LED3 + LED5+LED6 );
	
	const_light_legacy(mode, 2, 0+0 + 0+0 );	// pause
	
	const_light_legacy(mode, 1, 127 );	//r
	const_light_legacy(mode, 1, LED4+LED7 );
	const_light_legacy(mode, 1, LED3+LED7 );
	const_light_legacy(mode, 1, LED1+LED2+LED5+LED6 );
	
	const_light_legacy(mode, 5, 0+0 + 0+0 );	// big pause
}



void demo(){
	static unsigned char ds=1;
	static unsigned char dm=1;
	unsigned char rm=1;

	rm=mode;
	mode=dm;
	make_serie(ds);
	mode=rm;
	
	if (++dm>DEMO_M_NUM){
		dm=1;
		
		if (++ds>DEMO_S_NUM){
			ds=1;
		}
	}
}

void demo_long(){
	static unsigned char ds=1;
	static unsigned char dm=1;
	static unsigned char counter=0;
	unsigned char rm=1;

	rm=mode;
	mode=dm;
	make_serie(ds);
	mode=rm;
	
	if (++counter==255){
		counter=0;
		if (++dm>DEMO_M_NUM){
			dm=1;
			
			if (++ds>DEMO_S_NUM){
				ds=1;
			}
		}
	}
}




