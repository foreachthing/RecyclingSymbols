module Recycling_Symbol(Symbol, Numerical_Code, Plastic_Symbol, Font_Size, Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length, x_mirror){

font_quality = 35;

ncwidth = 1;
ncheight = 22;

pswidth = 1;
psheight = 15;

// https://www.maisfontes.com/helvetica-rounded-lt-std-bold.font
font = "Helvetica Rounded LT Std:style=Bold";


if (Symbol == 1){
	$fn = 10;
	mirror([x_mirror,0,0]){
		Recoverable_Plastic(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length);

		translate([0,-1,-Thickness*.5])
			linear_extrude(Thickness) {
				text(Numerical_Code, size=Font_Size, font=font, halign="center", valign="center", $fn=font_quality);
			}
		
		translate([0, Width/-2,-Thickness*.5])
			linear_extrude(Thickness) {
				text(Plastic_Symbol, size=8, font=font, halign="center", valign="center", $fn=font_quality);
			}
	}


} if (Symbol == 2){

	Nonrecoverable_Plastic(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length);

} if (Symbol == 3){
	
	Re_Recycled_Plastics(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length);

    translate([0,-ncheight/4,0])
        scale([1, 1, Thickness])
            text(Numerical_Code, Font_Size+2, font=font, halign="center", valign="baseline");
    
	translate([0, Width/-1.4,0])
		scale([1, 1, Thickness])
			translate([0,psheight/-4,0])
                text(Plastic_Symbol, 8, font=font, halign="center", valign="baseline");

} if (Symbol == 4){
	
	Reworked_Plastics(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length);

    translate([0,-ncheight/4,0])
        scale([1, 1, Thickness])
            text(Numerical_Code, Font_Size+2, font=font, halign="center", valign="baseline");
    
	translate([0, Width/-1.4,0])
		scale([1, 1, Thickness])
			translate([0,psheight/-4,0])
                text(Plastic_Symbol, 8, font=font, halign="center", valign="baseline");

} if (Symbol == 5){

	Repeatable_Plastic(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length);

    translate([0,-ncheight/5,0])
        scale([1, 1, Thickness])
            text(Numerical_Code, Font_Size+2, font=font, halign="center", valign="baseline");
    
	translate([0, Width/-1.6,0])
		scale([1, 1, Thickness])
			translate([0,psheight/-4,0])
                text(Plastic_Symbol, 8, font=font, halign="center", valign="baseline");

}

}
		
//********************************************
//Re-Recycled Plastic
//********************************************

module Re_Recycled_Plastics(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length){

difference(){

	cylinder(h = Thickness, r = Width/2, center = true);

	cylinder(h = Thickness+.1, r = Width/2-Arrow_Width, center = true);

	translate([0, Width/2-Arrow_Width/2-1,0])
		cube([Width/4, Arrow_Width*2+5, Thickness+.1], center = true);

}

translate([Width/-8+Arrow_Head_Length/2, ((Width/2)-Arrow_Width/2)-Width/64, 0])
	triangle(Arrow_Head_Length,Arrow_Head_Width, Thickness);

translate([Width/8,((Width/2)-Arrow_Width/2)-Width/64 , 0])
	cube([Arrow_Width/2, Arrow_Width*3, Thickness], center = true);

}

//********************************************
//Reworked Plastic
//********************************************

module Reworked_Plastics(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length){

difference(){

	cylinder(h = Thickness, r = Width/2, center = true);

	cylinder(h = Thickness+.1, r = Width/2-Arrow_Width, center = true);

	translate([0, Width/2-Arrow_Width/2-1,0])
		cube([Width/4, Arrow_Width*2+5, Thickness+.1], center = true);

	translate([Width/8-Width/16+Arrow_Width/2.25, ((Width/2)-Arrow_Width/2)-Width/	64, 0])
		cylinder(h = Thickness+.1, r = Width/12 - Arrow_Width/2, center = true);

}

translate([Width/-8+Arrow_Head_Length/2, ((Width/2)-Arrow_Width/2)-Width/64, 0])
	triangle(Arrow_Head_Length,Arrow_Head_Width, Thickness);

translate([Width/8-Width/16+Arrow_Width/2.25, ((Width/2)-Arrow_Width/2)-Width/64, 0])
	difference(){

	cylinder(h = Thickness, r = Width/12, center = true);

	cylinder(h = Thickness+.1, r = Width/12 - Arrow_Width/2, center = true);

}

}

//********************************************
//Nonrecoverable Plastic
//********************************************

module Nonrecoverable_Plastic(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length){

	Recoverable_Plastic();
	
	difference(){
	
		cylinder(h = Thickness, r = (Width/4)-Arrow_Head_Width/2, center = true);
	
		difference(){
	
			cylinder(h = Thickness+.1, r = (Width/4)-Arrow_Head_Width/2-1, center = true);
		
			rotate([0,0,-45])
				cube([((Width/2)*sqrt(3))/2, 1, Thickness+.1], center = true);
	
		}
	
	}

}

//********************************************
//Recoverable Plastic
//********************************************

module Recoverable_Plastic(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length){

	difference(){
	
		hull()
			for (i = [0:3]){
				rotate(i*360/3, [0,0,1])
					translate([0,((Width/2)*sqrt(3))/2+Arrow_Width/2,0])
						cylinder(h=Thickness, r=Arrow_Width/2, center = true);		
		}
		
		hull()
			for (i = [0:3]){
				rotate(i*360/3, [0,0,1])
					translate([0,(((Width-Arrow_Width*2)/2)*sqrt(3))/2+Arrow_Width/4, 0])
						cylinder(h = Thickness+.1, r = Arrow_Width/4, center = true);
		
		}
		
		rotate([0,0, 360/6])
			for (i = [0:3]){
				rotate(i*360/3, [0,0,1])
					translate([0,((Width/2)*sqrt(3))/4+1,0])
						cube([ Arrow_Head_Length+1,Arrow_Width+2, Thickness+.1], center = true);
		
		}
			
	
	}

rotate([0, 0, 360/6])
	for (i = [0:3]){
		rotate(i*360/3, [0,0,1])
			translate([-.5,sqrt((pow(Width/2,2)) - pow(((Width/2)*sqrt(3))/2,2)),0])
				triangle(Arrow_Head_Length, Arrow_Head_Width, Thickness);

}

}



//********************************************
//Repeatable Plastic
//********************************************

module Repeatable_Plastic(Length, Width, Thickness, Arrow_Width, Arrow_Head_Width, Arrow_Head_Length){

	scale([-1,-1,1]){
	
		translate([(Length)/2-Arrow_Head_Length,0,0]){
			
			translate([(Length- Arrow_Head_Length)/-2,Width/-2+Arrow_Head_Width,0])
				cube([(Length- Arrow_Head_Length), Arrow_Width, Thickness], center = true);
			
			translate([Arrow_Head_Length/2,Width/-2+Arrow_Head_Width,0])
				triangle(Arrow_Head_Length,Arrow_Head_Width, Thickness);
			
		}
	
	}
	
	translate([(Length)/2-Arrow_Head_Length,0,0]){
		
		translate([(Length- Arrow_Head_Length)/-2,Width/-2+Arrow_Head_Width,0])
			cube([(Length- Arrow_Head_Length), Arrow_Width, Thickness], center = true);
		
		translate([Arrow_Head_Length/2,Width/-2+Arrow_Head_Width,0])
			triangle(Arrow_Head_Length,Arrow_Head_Width, Thickness);
	
	}

}





module polygon(h,r,n){

	cylinder(h, (1/sin((180-(360/n))/2))*r, (1/sin((180-(360/n))/2))*r, $fn = n);

}


module triangle(l,w,h){

hull(){

	translate([l/-2,w/2,0])
		cylinder(h, r = .01, center = true);

	translate([l/-2,w/-2,0])
		cylinder(h, r = .01, center = true);

	translate([l/2,0, 0])
		cylinder(h, r = .01, center = true);

}

}

