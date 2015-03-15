//this is where all the easy to change dimensions and bolt sizes etc. are
//this file will be used by almost every other file

include <Fasteners.scad>
include <Electronics.scad>
include <IRSensorDimensions.scad>
include <BatteryDimensions.scad>

//note that max dimensions of soccer robots is:
// diameter of 220mm and height of 220mm

//
//BODY
//
bodyRadius =       		105;
motorIndent = 	   		35;
wheelClearance =   		2;
ballBiteRadius =   		100; //for the semi-circle section which holds the ball
ballBiteIndent = 		30; //how far the bite goes into the bottom plate	   
fenderThickness = 		2;
fenderDrop = 			3; //how far below the plate the fender goes
fenderHeight = 			35; //how far above the plate the fender goes
fenderSectorAngle = 	45; //degrees out of 360
fenderWingAngle = 		10; //degrees from straight ahead


//
//PLATES
//
plateThickness =     1.2;
distPlateMB =        65; //the distance between the middle plate and bottom
distPlateTM =        60; //the distance between the top plate and middle plate


//
//PILLARS
//
numPillars =            3; //number of pillars, equally spaced around robot
pillarType =     		M5Threaded;
pillarNutType =         M5Nut;
pillarWasherType = 		M5Washer;
pillarProtrusion = 		nutThickness(pillarNutType) + washerThickness(pillarWasherType) + 2; //the extra amount the pillar protrudes from each end
distPillarToEdge = 		threadDia(pillarType)*2; //distance from centre of pillar to edge of robot
frontPillar = 			0; //the number referring to the pillar in for loops 
frontPillarOffset = 	30; //allows the front pillar to be moved to make way for the bite


//
//ELECTRONICS
//
motorDriver = 		L298NHBridge;
motorDriverPos = 	[[-7, -60],[58, 7],[47, -48]];
controlBoard = 		OdroidU3;
controlBoardPos = 	[-2,55];
showBBB = 			false; //should the beaglebone be used
BBBPos = 			[10, 60];
camMountBolt =		M3Bolt;
boardClearance = 	1; //clearance for the soldered parts on underside of board

motorCableHolePos = [18, -10]; //position of the hole which allows cables to be fed to motors
cableHoleToMotors = 12; //Dia of hole for cables to motors

colSenseCablePos = 	[18, 15]; //position of the hole which allows cables to be fed to colour sensor on bot board
colSenseCableDia =	10;

numIRSensor =		5;
IRSensorBolt = 		M3Bolt;
IRSensorRotate = 	-8; //offset of rotation 
IRSensorDistEdge = 	5; //how far IR mount hole is from edge 
IRSensor = 			5mmIR;

batteryType = 		HobbyKing5000mAh;
batteryHolderBolt = M3Bolt;
batteryPos =		[0,0];
topCableHolePos = 	[25,-40];
topCableHoleDia = 	12;

//holes for lcd and camera on top plate
lcdCamCablePos =	[-20, 50];
lcdCamCableHoleDia= 17;
cameraDistToEdge = 	10;

//
//MECHANICAL
//
motorDia =    		25;
motorLength = 		52;
motorShaftDia = 	4;
motorShaftLength = 	12;
motorHoleSpacing =  17;
motorHoleType = 	M3Bolt;

//motor mount stuff
mountThickness = 	4;	//thickness used for pretty much all mounts
facePlateThickness= 2.5;
mountHoleType = 	M3Bolt;
mountBackOffset =   5; 	//distance the back mount is offset from flush with the back of motor
motorOffset = 		0;        //The motor is usually held at mount tab level, this moves it further up or down
mLength   = 		boltCorners(mountHoleType) * 2 + mountThickness; //the length of the section
tabLength = 		boltCorners(mountHoleType) * 2;

//
//WHEELS
//
wheelDia 		= 	63.6;
wheelThickness  = 	25;
wheelHubHole 	= 	8.7;
wheelHubHoleDepth = 7;	
wheelToMotor 	= 	5.5; //the distance from side of wheel to front of motor mount, allow space for bolts
wheelCouplingNut = 	M3Nut;
couplingSetScrew =  M3Bolt;
