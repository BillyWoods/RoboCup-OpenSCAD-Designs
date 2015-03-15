include <../Electronics.scad>
include <../Fasteners.scad>


cornerRadius = 3.5;
length = 83;
width = 48;
thickness = 1.6;

union()
{
	difference()
	{
		translate([-(length-2*cornerRadius)/2, -(width-2*cornerRadius)/2, 0])
		 minkowski()
		{
			//the cicuit board
			cube([length-2*cornerRadius, width-2*cornerRadius, thickness/2]);
			//the rounded corners
			cylinder(r = cornerRadius, h = thickness/2);
		}
		
		//the mounting holes
		translate([0,0,-0.5])
		 HoleTemplate(OdroidU3, thickness + 1, 0);
	}

	//the ethernet port
	translate([ -length/2 + 8,width/2 - 21, thickness - 0.05])
	 cube([16,21,13]);
	 
	//the USB ports
	//single port
	translate([-length/2 + 8 + 7 + 7 + 5, -width/2, thickness - 0.05])
	 cube([7, 16, 14]);
	//set of two
	translate([-length/2 + 8, -width/2, thickness - 0.05])
	 cube([14, 14, 15]);
	 
	//heatsink
	translate([-6, -width/2 + 7, thickness - 0.05])
	 cube([39, 41, 10]);
}