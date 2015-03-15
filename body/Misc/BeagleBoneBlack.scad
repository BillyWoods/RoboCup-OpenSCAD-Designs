include <../Electronics.scad>
include <../Fasteners.scad>


cornerRadius = 11.5;
length = 87;
width = 55;
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
		 HoleTemplate(BeagleBone, thickness + 1, 0.5);
	}

	//the ethernet port
	translate([ -(length/2 + 2.5),width/2 - 16 - 16, thickness - 0.05])
	 cube([21,16,13]);
	 
	//the USB port
	translate([length/2 -13, -width/2 + 10.5, thickness - 0.05])
	 cube([13.5, 13, 7]);

	//the headers
	//
	//top
	translate([-24.5, width/2 - 5 - 0.5, thickness - 0.05])
	 cube([58.6, 5, 9]);
	//bottom
	translate([-24.5, -(width/2 - 0.5), thickness - 0.05])
	 cube([58.6, 5, 9]);
}