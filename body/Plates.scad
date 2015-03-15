include <ParametricValues.scad>
include <Pillars.scad>
include <Electronics.scad>
include <Battery.scad>
include <Colours.scad>
include <MotorMount.scad>
include <IRMount.scad>
include <Camera.scad>

//has the motors and electronics boards
module BottomPlate()
{	
	difference()
	{
		//the plate
		color(plateColour)
		 cylinder(r=bodyRadius, h=plateThickness);
		
		//the motor mount holes and cut-outs
		for(i = [0:2])
		{
			rotate([0, 0, 120*i])
			 translate([0, bodyRadius - motorIndent,-0.5])
			  MountHoleTemplate(plateThickness+1);
			
			rotate([0, 0, 120*i])
			 translate([-((wheelDia)/2 + wheelClearance), bodyRadius - motorIndent, -0.5])
			  cube([wheelDia + wheelClearance*2, motorIndent + 1, plateThickness + 1]);
		}
		
		//the holes for the pillars
		rotate([0, 0, 360/(numPillars*2)])
		 translate([0, 0, -0.5])
		  PillarHoleTemplate(plateThickness + 1);
		  
		//the bite for the ball
		rotate([0, 0, frontPillar*(360/numPillars) + (360/(numPillars*2))])
		 translate([0,bodyRadius + ballBiteRadius - ballBiteIndent,-0.5])
		  cylinder(r = ballBiteRadius, h = plateThickness + 1);
	}
}

//has the camera, magnetometer
module MiddlePlate()
{
	difference()
	{
		//the plate
		color(plateColour)
		 cylinder(r=bodyRadius, h=plateThickness);
		
		//the holes for the pillars
		rotate([0, 0, 360/(numPillars*2)])
		 translate([0, 0, -0.5])
		  PillarHoleTemplate(plateThickness + 1);
		
		//control board holes
		translate([0, 0, -0.5])
		 translate(controlBoardPos)
		  HoleTemplate(controlBoard, plateThickness + 1, 0.5);
		
		//beaglebone holes
		if(showBBB==true)
		{
			translate([0, 0, -0.5])
			 translate(BBBPos)
			  //rotate([0, 0, -90])
			   HoleTemplate(BeagleBone, plateThickness + 1, 0.5);
		}
		
		//motor driver holes
		//left
		translate([0, 0, -0.5])
		 translate(motorDriverPos[0])
		  HoleTemplate(L298NHBridge, plateThickness + 1, 0.5);
		
		//middle
		translate([0, 0, -0.5])
		 translate(motorDriverPos[1])
		  HoleTemplate(L298NHBridge, plateThickness + 1, 0.5);
		
		//right
		translate([0, 0, -0.5])
		 translate(motorDriverPos[2])
		  HoleTemplate(L298NHBridge, plateThickness + 1, 0.5);
		  
		//cable hole to motor
		translate([0, 0, -0.5])
		 translate(motorCableHolePos)
		  cylinder(r = cableHoleToMotors/2, h = plateThickness + 1);
		  
		//cable hole to colour sensors
		translate([0, 0, -0.5])
		 translate(colSenseCablePos)
		  cylinder(r = colSenseCableDia/2, h = plateThickness + 1);
		
		//holes for IR sensors
		translate([0, 0, -0.5])
		 rotate([0, 0, IRSensorRotate])
		  IRholeTemplate();
	}
}

//has battery and any interface devices, also a handle
module TopPlate()
{
	difference()
	{
		color(plateColour)
		 cylinder(r=bodyRadius, h=plateThickness);
	
		rotate([0, 0, 360/(numPillars*2)])
		 translate([0, 0, -0.5])
		  PillarHoleTemplate(plateThickness + 1);
		  
		rotate([0, 0, 60])
		 translate(batteryPos)
		  BatteryHolderHoles(batteryType, M3Bolt, plateThickness + 1);
		
		//hole for battery cables
		translate(topCableHolePos)
		 translate([0, 0, -0.5])
		  cylinder(r = topCableHoleDia/2, h = plateThickness + 1);
		  
		//hole for camera usb and lcd disp
		translate(lcdCamCablePos)
		 translate([0, 0, -0.5])
		  cylinder(r = lcdCamCableHoleDia/2, h = plateThickness + 1);
		  
		//camera mount holes
		rotate([0, 0, 60])
		 translate([0, bodyRadius - cameraDistToEdge, -0.5])
		  CameraMountingHoleTemplate(plateThickness + 1);
	}
}

//translate([0,0,100])
 //projection()
  //TopPlate();

 //translate([0,0,50])
//projection()
//  MiddlePlate();

// color("red")
//projection()
// BottomPlate();
