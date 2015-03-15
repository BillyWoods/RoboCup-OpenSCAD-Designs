include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>

module Wheel()
{
	color(wheelColour)
	 difference()
	{
		//wheel body
		cylinder(r = wheelDia/2, h = wheelThickness);
		
		//hole for axle
		translate([0, 0, -0.5])
		 cylinder(r = wheelHubHole/2, h = wheelThickness + 1);
	}
}

//bodge values for tuning for printing
motorShaftDiaAdj = 0.6;
outerDiaAdj		 = 0.2; //for central prong
setScrewHoleAdj	 = 0.2;
ribAdj			 = 0.15; //extra space to allow ribs to fit
nutSizeBodge	 = 1.12; //a multiplier

//other stuff
bevelSize =			 	0.75;
wheelRibThickness =		2;
wheelHubRibThickness =  1.6;
wheelOuterHubDia =		23.5; 
captiveNutZOffset = 	0.5;
captiveNutDistEdge = 	5;

module WheelCoupling()
{	
	color(motorCouplingColour)
	 difference()
	{
		union()
		{
			//base and outer prongs for spokes
			difference()
			{
				//base
				cylinder(r = wheelOuterHubDia/2, h = wheelHubHoleDepth + wheelToMotor - 0.5);
				
				//negative to create a space around the central prong
				translate([0,0, wheelToMotor - 0.5])
				 cylinder(r = wheelHubHole/2 + wheelHubRibThickness + ribAdj/2, h = wheelHubHoleDepth + 1);
				 
				//left spoke prong
				translate([-wheelRibThickness/2 -ribAdj/2, -wheelRibThickness/2 - ribAdj/2, wheelToMotor - 0.5])
				 cube([wheelOuterHubDia, wheelOuterHubDia, wheelHubHoleDepth+1]);
				 
				//right spoke prong
				translate([-wheelOuterHubDia + wheelRibThickness/2 + ribAdj/2, -wheelOuterHubDia + wheelRibThickness/2 + ribAdj/2, wheelToMotor - 0.5])
				 cube([wheelOuterHubDia, wheelOuterHubDia, wheelHubHoleDepth+1]);
			}
			
			//central prong
			difference()
			{
				//central prong of coupling
				translate([0, 0, wheelToMotor - 0.6])
				 cylinder(r = (wheelHubHole + outerDiaAdj)/2, h = wheelHubHoleDepth + 0.1);
				
				//bevelled edge
				translate([0, 0, wheelHubHoleDepth + wheelToMotor - 0.5 - bevelSize])
				 difference()
				{	
					translate([-(wheelHubHole+bevelSize)/2, -(wheelHubHole+bevelSize)/2, 0])
					 cube([wheelHubHole+bevelSize, wheelHubHole+bevelSize, bevelSize + 1]);
					 
					translate([0, 0, -0.01])
					 cylinder(r1 = (wheelHubHole + outerDiaAdj)/2, r2 = (wheelHubHole)/2 - bevelSize, h = bevelSize);
				}
			}
		}
		
		rotate([0, 0, 45])
		{
			//Motor shaft hole
			translate([0, 0, -0.5]) //move it out so there is gap between faceplate and coupling
			 cylinder(r = (motorShaftDia + motorShaftDiaAdj)/2, h = motorShaftLength - facePlateThickness);
			 
			//set screw
			translate([0, 0, (wheelToMotor-0.5)/2 + captiveNutZOffset])
			 rotate([90, 0, 0])
			  cylinder(r = (boltHoleDia(couplingSetScrew) + setScrewHoleAdj)/2, h = wheelOuterHubDia/2 + 1);
		
			//captive nut trap
			translate([0, -wheelOuterHubDia/2 + captiveNutDistEdge,(wheelToMotor-0.5)/2 + captiveNutZOffset])
			 rotate([0, 90, -90])
			  union()
			{
				cylinder(r = nutCorners(wheelCouplingNut)*nutSizeBodge/2, h = nutThickness(wheelCouplingNut)*nutSizeBodge, $fn = 6);
				translate([0, -nutFlats(wheelCouplingNut)*nutSizeBodge/2, 0])
				 cube([10, nutFlats(wheelCouplingNut)*nutSizeBodge, nutThickness(wheelCouplingNut)*nutSizeBodge]);
			}
		}
	}
}


//translate([0, 0, wheelHubHoleDepth + wheelToMotor - 0.5])
 //rotate([180, 0 ,0])
  //WheelCoupling();
