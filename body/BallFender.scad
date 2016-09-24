include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>

smallHolePrintTol =         0.2; // adds this to the radius of small holes for printing

fenderHeightTotal =         fenderDrop + fenderHeight + plateThickness;
pillarTabWallThickness =    5;
rollerToMotorRad =          rollerRad + rollerMotorShaftRad - 0.30;
rollerAssemblyPosition =    [ballBiteRadius + rollerRad - fenderThickness - rollerProtrusion,0, fenderDrop - plateThickness + rollerVerticalPos];



module BallFender()
{
    color(ballFenderCol)
     intersection() // makes wings fit within robot footprint
    {
        // clears the bits of the wings protruding into plate space
        difference()
        {
            // adds wings, tabs and ball roller stuff
            union()
            {
                // curved backing and ledge which sits on plate
                difference()
                {
                    union()
                    {
                        cylinder(r = ballBiteRadius, h = fenderHeightTotal);
                        translate([0, 0, fenderDrop + plateThickness])
                         cylinder(r = ballBiteRadius + 2 * fenderThickness, h =  2 * fenderThickness);

                        // motor holders (without negative)
                        for (i = [0,1])
                        {
                            translate(rollerAssemblyPosition)
                             mirror([0,i,0])
                            {
                                translate([sin(rollerToMotorAngle) * rollerToMotorRad, rollerMotorHolderLen/2 + rollerLength/2 + 1, cos(rollerToMotorAngle) * rollerToMotorRad])
                                 union()
                                {
                                    translate([-(rollerMotorRad + 4), -rollerMotorHolderLen/2, -(rollerMotorRad + 3)])
                                     cube([rollerMotorRad + 4, rollerMotorHolderLen, (rollerMotorRad + 3) * 2]);
                                    rotate([90,0,0])
                                     cylinder(r = (rollerMotorRad + 3), h = rollerMotorHolderLen, center = true);
                                }
                            }
                        }
                    }

                    //negative through centre
                    translate([0, 0, -0.5])
                     cylinder(r = ballBiteRadius - fenderThickness, h = fenderHeightTotal + 1);
            
                    //minus two cubes to create a slice
                    rotate([0, 0, fenderSectorAngle/2])
                     translate([-ballBiteRadius*1.5, 0, -0.5])
                      cube([ballBiteRadius*3, ballBiteRadius*3, fenderHeightTotal + 1]);
                    rotate([0, 0, 180-fenderSectorAngle/2])
                     translate([-ballBiteRadius*1.5, 0, -0.5])
                      cube([ballBiteRadius*3, ballBiteRadius*3, fenderHeightTotal + 1]);
                }
        
                //tab which allows hole for pillar to mount the fender
                difference()
                {
                    translate([ballBiteRadius, -(threadDia(pillarType)/2 + pillarTabWallThickness), fenderDrop + plateThickness])
                     cube([distPillarToEdge + threadDia(pillarType)/2 + pillarTabWallThickness, threadDia(pillarType) + 2 * pillarTabWallThickness, 2 * fenderThickness]);
                    translate([ballBiteRadius + distPillarToEdge, 0, fenderDrop + plateThickness - 0.5])
                     cylinder(r = threadDia(pillarType)/2 + 0.2, h = 2 * fenderThickness + 1);
                }
        
                //top tab which allows hole for pillar to mount the fender
                if(fenderHeight > 8 * fenderThickness)
                {
                    difference()
                    {
                        translate([ballBiteRadius - fenderThickness, -(threadDia(pillarType)/2 + pillarTabWallThickness), fenderDrop + plateThickness + fenderHeight - 2 * fenderThickness])
                         cube([distPillarToEdge + threadDia(pillarType)/2 + pillarTabWallThickness + fenderThickness, threadDia(pillarType) + 2 * pillarTabWallThickness, 2 * fenderThickness]);
                        translate([ballBiteRadius + distPillarToEdge, 0, fenderDrop + plateThickness + fenderHeight - 2 * fenderThickness - 0.5])
                         cylinder(r = threadDia(pillarType)/2 + 0.2, h = 2 * fenderThickness + 1);
                    }
                }
        
                //wings to the side to retain the ball
                rotate([0, 0, -fenderSectorAngle/2 + 3])
                 translate([ballBiteRadius + 2*fenderThickness, 0, 0])
                  rotate([0, 0, fenderWingAngle + fenderSectorAngle/2])
                   translate([-ballBiteIndent, -fenderThickness/2, 0])
                    cube([ballBiteIndent, fenderThickness, fenderHeightTotal]);
        
                rotate([0, 0, fenderSectorAngle/2 - 3])
                 translate([ballBiteRadius + 2*fenderThickness, 0, 0])      
                  rotate([0, 0, -fenderWingAngle - fenderSectorAngle/2])
                   translate([-ballBiteIndent, -fenderThickness/2, 0])
                    cube([ballBiteIndent, fenderThickness, fenderHeightTotal]);

                // extra material for holding in roller shaft
                for (i = [0,1])
                {
                    translate(rollerAssemblyPosition)
                     mirror([0,i,0])
                    {
                        // cover ends of roller shaft
                        translate([0, rollerLength/2 + 0.5, 0])
                         scale([1,1.75,1])
                          intersection()
                        {
                            sphere(r = rollerID/2 + 2);
                            translate([0, 10, 0])
                             cube([20, 20, 20], center = true);
                        }
                    }
                }
            }

            // roller shaft hole negative
            translate(rollerAssemblyPosition)
             rotate([90,0,0])
              union()
            {
                cylinder(r = rollerID/2 + smallHolePrintTol, h = rollerShaftLen, center = true);
                hull()
                {
                    translate([rollerID/2 + 0.75, 0, 0])
                     cylinder(r = rollerID/2 + smallHolePrintTol, h = rollerShaftLen, center = true);
                    translate([rollerID/2 + 30, 0, 0])
                     cylinder(r = rollerID/2 + smallHolePrintTol, h = rollerShaftLen, center = true);
                }
            }

            //hole for roller
            translate(rollerAssemblyPosition)
             cube([2 * rollerRad + 2, rollerLength + 2, 2 * rollerRad + 1], center=true);

            // removes the bit of wings in the way of the plate
            difference()
            {   
                translate([0, -ballBiteRadius, -0.01])
                 cube([ballBiteRadius *2, ballBiteRadius *2, fenderDrop + plateThickness]);
            
                translate([0, 0, -0.5])
                 cylinder(r = ballBiteRadius, h = fenderDrop + plateThickness + 0.5);
            }   

            // motor negatives
            for (i = [0,1])
            {
                translate(rollerAssemblyPosition)
                 mirror([0,i,0])
                {
                    translate([sin(rollerToMotorAngle) * rollerToMotorRad, rollerLength/2 + 1 - 0.05, cos(rollerToMotorAngle) * rollerToMotorRad])
                     rotate([90,0,0])
                      scale([1.06,1.06,1.06])
                       RollerMotor();
                }
            }
        }
        
        //cut off ends of wings so that the robot fits within size limit
        translate([ballBiteRadius + bodyRadius - ballBiteIndent, 0, 0])
         cylinder(r = bodyRadius, h = fenderHeightTotal);
    }
}

module RollerMotor()
{
    color(motorColour)
     translate([0, 0, -(rollerMotorLength + rollerMotorBossHeight + rollerMotorInnerBossHeight)]) 
      union()
    {
        // body
        cylinder(r = rollerMotorRad, h = rollerMotorLength);
        // big boss
        translate([0, 0, rollerMotorLength - 0.5])
         cylinder(r = rollerMotorBossRad, h = rollerMotorBossHeight + 0.5);
        // little boss/bushing
        translate([0, 0, rollerMotorLength + rollerMotorBossHeight - 0.5])
         cylinder(r = rollerMotorInnerBossRad, h = rollerMotorInnerBossHeight + 0.5);
        // shaft
        translate([0, 0, rollerMotorLength + rollerMotorBossHeight + rollerMotorInnerBossHeight - 0.5])
         cylinder(r = rollerMotorShaftRad, h = rollerMotorShaftLen+ 0.5);
    }
}

module BallRollerAssembly()
{
    translate(rollerAssemblyPosition)
    {
        rotate([90, 0, 0])
        {
            color(ballRollerCol)
            {
                // roller itself
                difference()
                {
                    cylinder(r = rollerRad, h = rollerLength, center = true);
                    cylinder(r = rollerID/2, h = rollerLength + 1, center = true);
                }
                 
            }
            // shaft through roller
            color("grey")
             cylinder(r = rollerID/2, h = rollerShaftLen, center = true);
        }

        // roller motors
        for (i = [0,1])
        {
            mirror([0,i,0])
            {
                rotate([0, rollerToMotorAngle, 0])
                 translate([0, (rollerLength/2 + 1), rollerToMotorRad])
                  rotate([90,0,0])
                   RollerMotor();
            }
        }
    }
}


//translate([30, 0, 75/2 - 10])
// sphere(r = 75/2);

//BallRollerAssembly();
// for printing:
//translate([0,0,fenderHeight + fenderDrop + plateThickness])
//rotate([0,180,0])
//translate([-ballBiteRadius, 0, 0])
//BallFender();
