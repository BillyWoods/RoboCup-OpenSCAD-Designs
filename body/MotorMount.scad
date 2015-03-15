include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>


//the mount is in two parts

module MotorMountFront()
{
	translate([0, -mLength, 0])
	 color(motorMountColour)
	  difference()
	{
		union()
		{
			hull()
			{
				translate([0,0,motorDia/2 + mountThickness + motorOffset])
				 rotate([-90,0,0])
				  cylinder(r = motorDia/2 + mountThickness, h = mLength);
				
				translate([-(motorDia/2 + mountThickness), 0 , 0])
				 cube([motorDia + 2*mountThickness, mLength, mountThickness]);
			}
			
			//screw tabs
			translate([- (motorDia/2 + mountThickness + (tabLength)), 0, 0])
			 cube([motorDia + 2*mountThickness + 2*(tabLength), mLength, mountThickness]);
			
			//reinforcing for tabs
			translate([0, mountThickness/2, mountThickness - 0.05])
			 rotate([90,0,0])
			  linear_extrude(height = mountThickness/2)
			   projection()
			    rotate([-90, 0, 0])
			     cylinder(r2 = motorDia/2.5 + mountThickness, r1 = motorDia/2 + mountThickness + tabLength, h = motorDia/1.2 + motorOffset);
			translate([0, mLength, mountThickness - 0.05])
			 rotate([90,0,0])
			  linear_extrude(height = mountThickness/2)
			   projection()
			    rotate([-90, 0, 0])
			     cylinder(r2 = motorDia/2.5 + mountThickness, r1 = motorDia/2 + mountThickness + tabLength, h = motorDia/1.2 + motorOffset);
		}
		
		//hole for the motor
		translate([0, -facePlateThickness, motorDia/2 + mountThickness + motorOffset])
		 rotate([-90, 0, 0])
		  cylinder(r = motorDia/2, h = mLength + 1);
		  
		//hole for motor shaft
		translate([ 0, mLength - mountThickness - 0.5, mountThickness + motorDia/2 + motorOffset])
		 rotate([-90, 0, 0])
		  cylinder(r = (motorShaftDia + 3.5)/2, h = mountThickness + 1);
		
		
		//holes for screwing down mount
		translate([motorDia/2 + mountThickness + tabLength/2, mLength/2, -0.5])
		 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = mountThickness + 1);
		translate([-(motorDia/2 + mountThickness + tabLength/2), mLength/2, -0.5])
		 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = mountThickness + 1);
		
		//holes for motor face bolts
		translate([ motorHoleSpacing/2, mLength - mountThickness - 0.5, mountThickness + motorDia/2 + motorOffset])
		 rotate([-90, 0, 0])
		  cylinder(r = (boltHoleDia(motorHoleType) + 0.5)/2, h = mountThickness + 1);
		translate([ -motorHoleSpacing/2, mLength - mountThickness - 0.5, mountThickness + motorDia/2 + motorOffset])
		 rotate([-90, 0, 0])
		  cylinder(r = (boltHoleDia(motorHoleType) + 0.5)/2, h = mountThickness + 1);
		
		//make sure the bottom is flush if an offset for the motor is used
		translate([- (motorDia/2 + mountThickness + (tabLength)), -0.5, -mountThickness])
		 cube([motorDia + 2*mountThickness + 2*(tabLength), mLength + 1, mountThickness]);
	}
} 



module MotorMountBack()
{	
	translate([0, -(motorLength + facePlateThickness - mountBackOffset), 0])
	 color(motorMountColour)
	  difference()
	{
		union()
		{
			hull()
			{
				translate([0,0,motorDia/2 + mountThickness + motorOffset])
				 rotate([-90,0,0])
				  cylinder(r = motorDia/2 + mountThickness, h = mLength);
				
				translate([-(motorDia/2 + mountThickness), 0 , 0])
				 cube([motorDia + 2*mountThickness, mLength, mountThickness]);
			}
			
			//screw tabs
			translate([- (motorDia/2 + mountThickness + (tabLength)), 0, 0])
			 cube([motorDia + 2*mountThickness + 2*(tabLength), mLength, mountThickness]);
			
			//reinforcing for tabs
			translate([0, mountThickness/2, mountThickness - 0.05])
			 rotate([90,0,0])
			  linear_extrude(height = mountThickness/2)
			   projection()
			    rotate([-90, 0, 0])
			     cylinder(r2 = motorDia/2.5 + mountThickness, r1 = motorDia/2 + mountThickness + tabLength, h = motorDia/1.2 + motorOffset);
			translate([0, mLength, mountThickness - 0.05])
			 rotate([90,0,0])
			  linear_extrude(height = mountThickness/2)
			   projection()
			    rotate([-90, 0, 0])
			     cylinder(r2 = motorDia/2.5 + mountThickness, r1 = motorDia/2 + mountThickness + tabLength, h = motorDia/1.2 + motorOffset);
		}
		
		//hole for the motor
		translate([0, -0.5, motorDia/2 + mountThickness + motorOffset])
		 rotate([-90, 0, 0])
		  cylinder(r = motorDia/2, h = mLength + 1);
		  
		//holes for screwing down mount
		translate([motorDia/2 + mountThickness + tabLength/2, mLength/2, -0.5])
		 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = mountThickness + 1);
		translate([-(motorDia/2 + mountThickness + tabLength/2), mLength/2, -0.5])
		 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = mountThickness + 1);
		
		//make sure the bottom is flush if an offset for the motor is used
		translate([- (motorDia/2 + mountThickness + (tabLength)), -0.5, -mountThickness])
		 cube([motorDia + 2*mountThickness + 2*(tabLength), mLength + 1, mountThickness]);
	}
}

module Motor()
{
	rotate([90,0,0])
	 color(motorColour)
	  union()
	{
		cylinder(r = motorDia/2, h = motorLength);
		translate([0,0,-motorShaftLength])
		 cylinder(r = motorShaftDia/2, h = motorShaftLength);
	}
}

module MountHoleTemplate(length)
{
	//rotate([0,0,180])
	 translate([0, -mLength/2 ,0])
	{
		//front motor mount hole
		translate([motorDia/2 + mountThickness + tabLength/2, 0, -0.5])
		 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = length + 1);
		translate([-(motorDia/2 + mountThickness + tabLength/2), 0, -0.5])
		 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = length + 1);
		 
		//back motor mount hole
		translate([motorDia/2 + mountThickness + tabLength/2, -(motorLength + facePlateThickness - mLength - mountBackOffset), -0.5])
		 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = length + 1);
		translate([-(motorDia/2 + mountThickness + tabLength/2), -(motorLength + facePlateThickness - mLength - mountBackOffset), -0.5])
		cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = length + 1);
	}	
}

/*
rotate([90, 0, 0])
 translate([0, motorLength + facePlateThickness - mountBackOffset, 0])
  MotorMountBack();

translate([50,-30,mLength])
 rotate([-90, 0, 0])
  translate([0, mLength, 0])
   MotorMountFront();
*/

//translate([0,-2.5,mountThickness + motorDia/2])
//Motor();

//MountHoleTemplate(10);

