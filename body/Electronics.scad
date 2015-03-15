include <Fasteners.scad>
include <Colours.scad>




//
//ELECTRONICS CONTROLLER BOARDS
//

// [name on BOM, path to stl model if any, hole type, [hole top left position], [hole top right position], [hole bot right position], [hole bot left position] ]
ArduinoUNO =   [ "Arduino UNO",  "Arduino.stl", M3Bolt, 			[-19, 24.15], 	[31.8, 8.95], 	[31.8, -19.05], [-20.3, -24.15] ];
L298NHBridge = [ "L298N H-Bridge", "L298N.stl", M3Bolt, 			[-18.5, 18.5], 	[18.5, 18.5], 	[18.5, -18.5], 	[-18.5, -18.5] ];
BeagleBone =   [ "BeagleBone Black", "BeagleBoneBlack.stl", M3Bolt, [-28, 24], 		[38, 21], 		[38, -21], 		[-28, -24] ];
OdroidU3 = 	   [ "Ordoid U3",	"OdroidU3.stl",	M3Bolt, 			[-38, 20.5],	[38, 20.5],		[38, -20.5],	[-38, -20.5]];

//functions for getting useful dimensions
function boardName(type) = type[0];
function getModelPath(type) = type[1];
function boardHoleDia(type) = boltHoleDia(type[2]);
function getHolePos(type, holeNum) = type[holeNum+3]; //hole num starts at 0

//used to get a hole template for difference operations
module HoleTemplate(board, boltLength, clearance)
{
	for(i=[0:3])
	{
		echo(i);
		translate(getHolePos(board, i))
		 cylinder(r = (boardHoleDia(board)+clearance)/2, h = boltLength);
	}
}




//
//module to create a model of the boards, mainly visual
//

module DisplayBoard(type)
{
	//arduino model is not properly centred
	if(type == ArduinoUNO)
	{
		translate([-19, 24.15, 0])
		 color(boardColour)
		  import(getModelPath(type));
	}
	
	else
	{
		color(boardColour)
		 import(getModelPath(type));
	}
	
	echo(boardName(type));
}

/*
translate([0,0,20])
translate(ArduinoUNO[3])
 DisplayBoard(ArduinoUNO);

difference()
{	
	translate([-50, -35, 0.1])
	cube([100,70,5]);
	HoleTemplate(ArduinoUNO, 20, 0.5);
}
*/
