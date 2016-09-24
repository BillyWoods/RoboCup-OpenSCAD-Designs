//this file gives a good graphical representation of all the 
//various parts put together and not much else

include   <ParametricValues.scad>
include   <Electronics.scad>
include   <MotorMount.scad>
include   <IRMount.scad>
include   <Wheels.scad>
include   <BallFender.scad>
include   <Camera.scad>
include   <Pillars.scad>
include   <Plates.scad>
include   <UltrasonicMount.scad>





//The plates
BottomPlate();

translate([0,0,distPlateMB])
 MiddlePlate();

translate([0,0,distPlateMB + distPlateTM])
 TopPlate();

//the pillars
rotate([0,0,360/(numPillars*2)])
 Pillars(showNutsWashers = true, printToBOM = true);

//the motors and their mounts
for(i = [0:2])
{
    rotate([0, 0, i*120])
     translate([0, bodyRadius - motorIndent, plateThickness])
    {
        if (motorType == "CYLINDER")
        {
            MotorMountFront();
            MotorMountBack();
            translate([0, -facePlateThickness, motorDia/2 + mountThickness + motorOffset])
             Motor();
        }
        else if (motorType == "SQUARE")
        {
            SquareMotorMount();
            translate([0, -facePlateThickness, motorDia/2])
             Motor();
        }
    }
}

//the control board
//odroid needs to be flipped upside down
if(controlBoard == OdroidU3)
{
    translate([ 0, 0, distPlateMB + plateThickness + boardClearance + 20])
     translate(controlBoardPos)
      rotate([0, 180, 0])
       DisplayBoard(controlBoard);
}

else
{
    translate([ 0, 0, distPlateMB + plateThickness + boardClearance])
     translate(controlBoardPos)
      DisplayBoard(controlBoard);
}
  
//the beaglebone black
if(showBBB == true)
{
    translate([ 0, 0, distPlateMB + plateThickness + boardClearance])
     translate(BBBPos)
      //rotate([0, 0, -90])
       DisplayBoard(BeagleBone);
}

//
//H Bridges
//left
translate([ 0, 0, distPlateMB + plateThickness + boardClearance])
 translate(motorDriverPos[0])
  DisplayBoard(L298NHBridge);

//middle
translate([ 0, 0, distPlateMB + plateThickness + boardClearance])
 translate(motorDriverPos[1])
  DisplayBoard(L298NHBridge);

//right
translate([ 0, 0, distPlateMB + plateThickness + boardClearance])
 translate(motorDriverPos[2])
  DisplayBoard(L298NHBridge);
  

//wheels and couplings
for(i = [0:2])
{
    if(motorType == "CYLINDER")
    {
        //wheels
        rotate([0, 0 , i * (360/3)])
         translate([0, bodyRadius - motorIndent + wheelToMotor, plateThickness + mountThickness + motorDia/2])
          rotate([-90,0,0])
           Wheel();
        
        //motor couplings   
        rotate([0, 0 , i * (360/3)])
         translate([0, bodyRadius - motorIndent + 0.5 - 0.05, plateThickness + mountThickness + motorDia/2])
          rotate([-90,0,0])
           WheelCoupling();
    }

    else if(motorType == "SQUARE")
    {
        //wheels
        rotate([0, 0 , i * (360/3)])
         translate([0, bodyRadius - motorIndent + wheelToMotor, plateThickness + motorDia/2])
          rotate([-90,0,0])
           Wheel();
        
        //motor couplings   
        rotate([0, 0 , i * (360/3)])
         translate([0, bodyRadius - motorIndent + 0.5 - 0.05, plateThickness + motorDia/2])
          rotate([-90,0,0])
           WheelCoupling();
    }
}

//IRsensors and mounts
translate([0, 0, distPlateMB + plateThickness])
 rotate([0, 0, IRSensorRotate])
 for(i = [0:numIRSensor-1])
{
    rotate([0, 0, i * (360/numIRSensor)])
     translate([0,bodyRadius - IRSensorDistEdge,0])
     {
        IRAssembly();
     }
}

//the ultrasonic sensors
for (i = [0:3])
{
    rotate([0, 0, i*90 - 30])
     translate([0, bodyRadius - ultrasonicDistEdge, distPlateMB + plateThickness + 0.05])
      UltrasonicSensorAssembly(ultrasonicType);
}

//battery and its holder
rotate([0, 0, 60])
 translate([0, 0, distPlateMB + distPlateTM + plateThickness])
  translate(batteryPos)
{
    Battery(batteryType);
    BatteryHolderBack(batteryType);
    BatteryHolderFront(batteryType);
}


//fender on front for ball
rotate([0, 0, -30])
 translate([-ballBiteRadius - bodyRadius + ballBiteIndent, 0, -fenderDrop + 0.05])
{
    BallRollerAssembly();
    BallFender();
}
  
//camera mounts
rotate([0, 0, 60])
 translate([0, bodyRadius - cameraDistToEdge, distPlateMB + distPlateTM + plateThickness])
  CameraMountVisualisation();
