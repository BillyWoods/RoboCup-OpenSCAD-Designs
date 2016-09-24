include <ParametricValues.scad>
include <UltrasonicSensorDimensions.scad>
include <Fasteners.scad>
include <Colours.scad>





//oscillator dimensions
osLength =  11;
osHeight = 	3.5;
osWidth =	4.6;

clearance = 0.75; //general clearance, such as round the transducers
mountThickness = 3;
SMDClearance = 1.7; //for the smd chips on the back of the board

	
module UltrasonicSensor(type)
{	
	xMiddle = USBoardWidth(type)/2;
	zMiddle = USBoardHeight(type)/2;
	
	union()
	{
		//pcb
		color(ultrasonicColour)
		 translate([0, -USBoardThickness(type), 0])
		 cube([USBoardWidth(type), USBoardThickness(type), USBoardHeight(type)]);
		 
		color(ultrasonicTransducerCol)
		{
			//transducers
			//right transducer
			translate([xMiddle - USTransducerSpacing(type)/2, 0, zMiddle])
			 rotate([-90, 0, 0])
			  cylinder(r = USTransducerDia(type)/2, h = USTransducerHeight(type));
			
			//left transducer
			translate([xMiddle + USTransducerSpacing(type)/2, 0, zMiddle])
			 rotate([-90, 0, 0])
			  cylinder(r = USTransducerDia(type)/2, h = USTransducerHeight(type));
			  
			//oscillator
			translate([xMiddle - osLength/2, 0, 0])
			 cube([osLength, osHeight, osWidth]);
		}
	}
}



module UltrasonicMount(type)
{	
	mountWidth = USTransducerSpacing(type) - USTransducerDia(type) - clearance;
	//extra length for when the sensor is angled over the bolt
	extraScrewTabLength = ultrasonicAngle < 0 ? sin(-ultrasonicAngle)*(ultrasonicHeight + USBoardHeight(type) - (2.54 + clearance)) : 0;
	
	color(ultrasonicMountColour)
	 translate([-mountWidth/2, mountThickness, 0])
	  difference()
	{
		union()
		{
			rotate([ultrasonicAngle, 0, 0])
			//translate all but the screw tab into position to apply rotation
			translate([0, -osHeight - clearance/2 - mountThickness, ultrasonicHeight])
			{
				//front side tab
				translate([0, 0, -0.05])
				 difference()
				{
					cube([mountWidth, mountThickness + clearance/2 + osHeight, USBoardHeight(type) - (2.54 + clearance)]);
					
					//gap for oscillator and to allow a clip on
					translate([-0.5, -0.05, -0.05])
					cube([mountWidth+1, osHeight + clearance/2, osWidth *2.3]);
				}
				
				//back side tab
				translate([0, -(mountThickness + USBoardThickness(type) + SMDClearance), -0.05])
				 cube([mountWidth, mountThickness, USBoardHeight(type) - (2.54 + clearance)]);
				 
				//bottom connection piece
				translate([0, -(mountThickness + USBoardThickness(type) + SMDClearance), -mountThickness])
				 cube([mountWidth, 2*mountThickness + clearance/2 + osHeight + USBoardThickness(type) + SMDClearance, mountThickness]);
				
				//stalk the mount sits on, connects it to screw hole
				translate([0, osHeight + clearance/2, -ultrasonicHeight])
				 cube([mountWidth, mountThickness, ultrasonicHeight]);
			}
			 
			//screw tab
			//if statement stops tab poking out the back when stalk is tilted forwards
			if(ultrasonicAngle >= 0)
			{
				translate([0, -mountThickness, 0])
				 cube([mountWidth, mountWidth + extraScrewTabLength + mountThickness, mountThickness]);
			}
			else
			{
				 cube([mountWidth, mountWidth + extraScrewTabLength, mountThickness]);
			}
		}
		
		//take out screw hole
		translate([mountWidth/2, mountWidth/2 + extraScrewTabLength, -0.5])
		cylinder(r = (boltHoleDia(ultrasonicBolt) + clearance)/2, h = mountThickness + 1, $fn=8);
		
		//make the bottom flat
		translate([0, 0,-30/2])
		 cube([50, 50, 30], center=true);
	}
}

module UltrasonicSensorAssembly(type)
{
	UltrasonicMount(type);

	translate([0,mountThickness,0])
	 rotate([ultrasonicAngle, 0, 0])
	  translate([-USBoardWidth(type)/2, -osHeight - clearance/2 - mountThickness,ultrasonicHeight])
	   UltrasonicSensor(type);
}

module UltrasonicMountHole(type)
{
	mountWidth = USTransducerSpacing(type) - USTransducerDia(type) - clearance;
	//extra length for when the sensor is angled over the bolt
	extraScrewTabLength = ultrasonicAngle < 0 ? sin(-ultrasonicAngle)*(ultrasonicHeight + USBoardHeight(type) - (2.54 + clearance)) : 0;
	
	for (i = [0:3])
	{
		rotate([0, 0, i*90 - 30])
		 translate([0, bodyRadius - ultrasonicDistEdge, -0.05])
		  translate([0, mountWidth/2 + mountThickness + extraScrewTabLength,0])
		   children();
	}
}

//for printing
// translate([0,0,(USTransducerSpacing(ultrasonicType) - USTransducerDia(ultrasonicType) - clearance)/2])
//  rotate([0, 90, 0])
//   UltrasonicMount(ultrasonicType);

//UltrasonicSensorAssembly(ultrasonicType);
//UltrasonicMountHole(ultrasonicType) cylinder(r=3,h=3); 
