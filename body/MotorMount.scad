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
        translate([ 0 , mLength - mountThickness - 0.5, mountThickness + motorDia/2 + motorOffset])
         rotate([-90, 0, 0])
          MotorHoleSpacing(motorType)
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



module SquareMotorMount()
{
    difference()
    {
        translate([0, -facePlateThickness/2, motorDia/2])
         color(motorMountColour)
        union()
        {
            // faceplate
            difference()
            {
                cube([motorDia + mClearance + 2*mountThickness, facePlateThickness,  motorDia], center=true);
                // motor mounting holes
                rotate([-90, 0, 0])
                 MotorHoleSpacing(motorType)
                  cylinder(r = boltHoleDia(motorHoleType)/2 + 0.25, h = facePlateThickness + 0.5, center=true);
                // circular cutout for boss and shaft
                rotate([-90, 0, 0])
                 cylinder(r = motorBossDia/2 + mClearance, h = facePlateThickness + 0.5 , center=true);
            }

            // sides and tabs
            for (i=[0:1])
            {
                mirror([i,0,0])
                union()
                {
                    // angled side
                    translate([-(motorDia + mClearance)/2, -(mLength - facePlateThickness/2 - 0.05), -motorDia/2])
                     rotate([0, -90, 0])
                      linear_extrude(height = mountThickness, convexity=10, twist=0)
                       polygon(
                      points = 
                          [ [0,0], [0, mLength-facePlateThickness], [motorDia, mLength-facePlateThickness], [mountThickness, 0] ],
                      paths = 
                          [ [0,1,2,3] ]
                       );
                    // tab
                    translate([-(tabLength + (motorDia+mClearance)/2 + mountThickness - 0.05), -mLength + facePlateThickness/2, -motorDia/2])
                     cube([tabLength, mLength, mountThickness]);
                }
            }
        }

        // holes in mounting tabs
        translate([0, 0, -0.5])
        MountHoleTemplate(mountThickness + 1);
    }
}



module Motor()
{
    rotate([90,0,0])
     color(motorColour)
     difference()
     {
        union()
        {
            if (motorType == "CYLINDER")
            {
                cylinder(r = motorDia/2, h = motorLength);
                translate([0,0,-motorShaftLength])
                 cylinder(r = motorShaftDia/2, h = motorShaftLength);
            }   
            else if (motorType == "SQUARE")
            {
                translate([0,0,motorLength/2])
                 cube([motorDia, motorDia, motorLength], center=true);   
                translate([0,0,-motorShaftLength])
                 cylinder(r = motorShaftDia/2, h = motorShaftLength);
            }
            else { echo("Unknown motor type specified!"); }
        }
        translate([0, 0, -0.05])
         MotorHoleSpacing(motorType)
          cylinder(r = boltHoleDia(motorHoleType)/2, h = 8);
    }
}



module MotorHoleSpacing(type)
{
    if (type == "CYLINDER")
    {
        translate([motorHoleSpacing/2, 0, 0])
         child();
        translate([-motorHoleSpacing/2, 0, 0])
         child();
    }
    else if (type == "SQUARE")
    {
        for (i = [0:3])
        {
            rotate([0, 0, 45 + 90*i])
             translate([sqrt(2)*(motorHoleSpacing/2), 0, 0])
              child();
        }
    }
}



module MountHoleTemplate(length)
{
    if(motorType == "CYLINDER")
    {
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
    else if (motorType == "SQUARE")
    {
        translate([0, -tabLength/2, 0])
         for (i = [0:1])
        {
            for (j = [1,-1])
            {
                translate([j*((motorDia + mClearance + tabLength)/2 + mountThickness), -i*(mLength-tabLength), 0])
                 cylinder(r = (boltHoleDia(mountHoleType) + 0.5)/2, h = length + 1);
            }
        }
    }
}


//rotate([90, 0, 0])
// translate([0, motorLength + facePlateThickness - mountBackOffset, 0])
//  MotorMountBack();

//translate([50,-30,mLength])
// rotate([-90, 0, 0])
//  translate([0, mLength, 0])
//   MotorMountFront();

//rotate([-90, 0, 0])
// SquareMotorMount();


//translate([0,-2.5,mountThickness + motorDia/2])
//Motor();


