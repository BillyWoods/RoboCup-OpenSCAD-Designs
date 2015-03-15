include <../Electronics.scad>
include <../Fasteners.scad>





//
//create a rough model of the L298N board 
//

boardWidth = 43;
boardLength = 43;
boardThickness = 1.6;


difference()
{
	translate([-43/2, -43/2, 0])
	 union()
	 {
		//the PCB
		 cube([boardWidth, boardLength, boardThickness]);

		//the heatsink
		translate([(43-25)/2, 43-15, 0])
	 	 cube([25,15,27]);
		
		
		//
		//the terminal connections
		//
		//left
		translate([ 1, 11, boardThickness - 0.1])
		 cube([7, 8, 8.5]);
		
		//right
		translate([ boardWidth - 8, 11, boardThickness - 0.1])
		 cube([7, 8, 8.5]);

		//bottom
		translate([ 8, 1, boardThickness - 0.1])
		 cube([11.5, 7, 8.5]);
		 
		
		//the headers
		translate([ 8 + 11.5 + 1, 1, boardThickness - 0.1])
		 cube([15, 2.5, 9]);
		 
		//the capacitors
		translate([ 8 + 4 + 1, 17, boardThickness - 0.1])
		 cylinder(r = 4, h = 9);
		 
		translate([ 8 + 11.5 + 3 + 4, 5 + 5, boardThickness - 0.1])
		 cylinder(r = 4, h = 9);
	}

	//the drill holes
	translate([0,0,-1])
	 HoleTemplate(L298NHBridge, 20, 0.5);
}