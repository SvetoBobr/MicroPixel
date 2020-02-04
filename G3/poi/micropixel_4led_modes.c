

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
			case 4:
				mode_4();
				break;;
			case 5:
				mode_5();
				break;;			
			default:
				const_light(0, 1);
				break;;
		}
}

// ======== servise functions ==========================================================

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


// ========= modes ===============================================================
void mode_1(){	// const
	const_light_legacy(mode, 12, 255 );
}

void mode_2(){	// strob
	const_light_legacy(mode, 6, 255 );
	const_light_legacy(0, 6, 255 );
}

void mode_3(){	// gears
	const_light_legacy(mode, 60, LED1+LED2 );
	const_light_legacy(mode, 60, LED3+LED4 );
}

void mode_4(){	// chess
	const_light_legacy(mode, 60, LED1+LED3 );
	const_light_legacy(mode, 60, LED2+LED4 );
}

void mode_5(){	// flower
	const_light_legacy(mode, 30, LED1 );
	const_light_legacy(mode, 30, LED2 );
	const_light_legacy(mode, 30, LED3 );
	const_light_legacy(mode, 30, LED4 );

}

void mode_faded(){
	const_light_legacy(0, 30, 0 );
}


#define SP_L	2
#define	SB_L	1





