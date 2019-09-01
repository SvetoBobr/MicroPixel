// letters for 18 pix


void vV(){
	flush_mask(); mask[1]=mask[3]=mask[4]=mask[5]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[6]=mask[7]=mask[8]=mask[9]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[10]=mask[11]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[11]=mask[12]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[14]=mask[15]=mask[16]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[13]=mask[14]=mask[15]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[12]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[11]=mask[12]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[10]=mask[11]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[8]=mask[9]=mask[10]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[3]=mask[4]=mask[5]=mask[6]=mask[7]=mask[8]=mask[18]=1;
	const_light(s,1);
}

void vO(){
	fill_mask(); mask[2]=mask[3]=mask[17]=mask[16]=0;
	const_light(s,1);
	fill_mask(); mask[2]=mask[4]=mask[17]=mask[15]=0;
	const_light(s,1);
	flush_mask(); mask[1]=mask[3]=mask[16]=mask[18]=1;
	const_light(s,4);
	fill_mask(); mask[2]=mask[4]=mask[17]=mask[15]=0;
	const_light(s,1);
	fill_mask(); mask[2]=mask[3]=mask[17]=mask[16]=0;
	const_light(s,1);
}

void vL(){
	fill_mask(); mask[2]=mask[17]=0;
	const_light(s,1);
	flush_mask(); mask[1]=mask[16]=mask[18]=1;
	const_light(s,6);
}

void vK(){
	fill_mask(); mask[2]=mask[17]=0;
	const_light(s,1);
	flush_mask(); mask[1]=mask[8]=mask[9]=mask[10]=mask[11]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[7]=mask[8]=mask[11]=mask[12]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[6]=mask[12]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[5]=mask[6]=mask[12]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[4]=mask[5]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[4]=mask[13]=mask[14]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[3]=mask[4]=mask[14]=mask[15]=mask[16]=mask[18]=1;
	const_light(s,1);
}

void _S(){
	flush_mask(); mask[3]=mask[4]=mask[5]=mask[6]=mask[16]=1;
	const_light(s, 1);
	flush_mask(); mask[2]=mask[7]=mask[17]=1;
	const_light(s, 1);
	flush_mask(); mask[1]=mask[8]=mask[18];
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[18];
	const_light(s,3);
	flush_mask(); mask[1]=mask[10]=mask[18];
	const_light(s,1);
	flush_mask(); mask[1]=mask[11]=mask[18];
	const_light(s,1);
	flush_mask(); mask[1]=mask[12]=mask[18];
	const_light(s,1);
	flush_mask(); mask[3]=mask[13]=mask[14]=mask[15]=mask[16];
	const_light(s,1);
	flush_mask();
	const_light(s, 4);
}

void _V(){
	flush_mask(); mask[1]=mask[2]=mask[3]=mask[4]=1;
	const_light(s,1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=1;
	const_light(s,1);
	flush_mask(); mask[9]=mask[10]=mask[11]=mask[12]=1;
	const_light(s,1);
	flush_mask(); mask[13]=mask[14]=mask[15]=mask[16]=1;
	const_light(s,1);
	
	flush_mask(); mask[17]=mask[18]=1;
	const_light(s,1);
	
	flush_mask(); mask[13]=mask[14]=mask[15]=mask[16]=1;
	const_light(s,1);
	flush_mask(); mask[9]=mask[10]=mask[11]=mask[12]=1;
	const_light(s,1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[2]=mask[3]=mask[4]=1;
	const_light(s,1);
		flush_mask();
	const_light(s, 4);
}

void _E(){
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=mask[8]=mask[18]=1;
	const_light(s,15);
		flush_mask();
	const_light(s, 4);
}

void _T(){
	flush_mask(); mask[1]=1;
	const_light(s,6);
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=1;
	const_light(s,6);
		flush_mask();
	const_light(s, 4);
}

void _O(){
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=mask[9]=mask[10]=mask[11]=mask[12]=mask[13]=mask[14]=1;
	const_light(s, 1);	
	flush_mask(); mask[3]=mask[4]=mask[15]=mask[16]=1;
	const_light(s, 1);
	flush_mask(); mask[2]=mask[17]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[18]=1;
	const_light(s,3);
	flush_mask(); mask[2]=mask[17]=1;
	const_light(s,1);
	flush_mask(); mask[3]=mask[4]=mask[15]=mask[16]=1;
	const_light(s, 1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=mask[9]=mask[10]=mask[11]=mask[12]=mask[13]=mask[14]=1;
	const_light(s, 1);	
	flush_mask(); 
	const_light(s, 4);
}

void _B(){
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[18]=1;
	const_light(s,4);
	flush_mask(); mask[2]=mask[8]=mask[10]=mask[17]=1;
	const_light(s,2);
	fill_mask(); mask[1]=mask[2]=mask[8]=mask[9]=mask[10]=mask[17]=mask[18]=0;
	const_light(s,1);
	
	flush_mask(); 
	const_light(s, 4);
}

void _R(){
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[18]=1;
	const_light(s,3);
	flush_mask(); mask[2]=mask[8]=mask[10]=mask[11]=1;
	const_light(s,1);
	flush_mask(); mask[2]=mask[8]=mask[12]=mask[13]=1;
	const_light(s,1);
	flush_mask(); mask[3]=mask[4]=mask[5]=mask[6]=mask[7]=1;
	mask[14]=mask[15]=mask[16]=mask[17]=mask[18]=1;
	const_light(s,1);
	
	flush_mask(); 
	const_light(s, 4);
}

void vPause(unsigned char l){
	flush_mask(); mask[1]=mask[18]=1;
	const_light(s, l);
}
