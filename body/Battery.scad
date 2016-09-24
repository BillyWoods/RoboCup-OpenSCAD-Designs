//where the battery and its mount are modelled

include <BatteryDimensions.scad>
include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>

//clearance/tolerance values around the battery, gives extra space
batClearance =      0.5;
//length to part of tab which holds in battery
spTabLength =       14;
spTabThickness =    1.5;
spRidgeProtrude =   6;
spRidgeDepth =      6;

//simple model of a battery
module Battery(type)
{
    translate([-batteryLength(type)/2, -batteryWidth(type)/2, 0])
     color(batteryColour)
      cube([batteryLength(type), batteryWidth(type), batteryThickness(type)]);
}

module BatteryHolderFront(type)
{
    translate([batteryLength(type)/2 - spTabLength - 2*boltCorners(batteryHolderBolt), -batteryWidth(type)/2 - batClearance - mountThickness, 0])
     color(batteryHolderColour)
      difference()
    {
        union()
        {
            cube([2 * boltCorners(batteryHolderBolt), batteryWidth(type) + 2 * (mountThickness + batClearance), batteryThickness(type) + mountThickness + batClearance]);
            //tabs for screws
            translate([0, -2 * boltCorners(batteryHolderBolt) + 0.05, 0])
             cube([2 * boltCorners(batteryHolderBolt), 2 * boltCorners(batteryHolderBolt), mountThickness]);
            translate([0, batteryWidth(type) + 2 * (mountThickness + batClearance) - 0.05])
             cube([2 * boltCorners(batteryHolderBolt), 2 * boltCorners(batteryHolderBolt), mountThickness]);
            
            //Spring tab for securing battery
            translate([2*boltCorners(batteryHolderBolt) - 0.05, mountThickness + batteryWidth(type) + 2 * batClearance, 0])
             cube([spTabLength + batClearance + 0.1, spTabThickness, batteryThickness(type)]);
            //retaining ridge
            translate([2*boltCorners(batteryHolderBolt) + batClearance - 0.05 + spTabLength, mountThickness + batteryWidth(type) + 2 * batClearance - spRidgeProtrude, 0])
             cube([spRidgeDepth, spTabThickness + spRidgeProtrude, batteryThickness(type)]);
        }
        
        //mounting holes
        translate([(2 * boltCorners(batteryHolderBolt))/2, -boltCorners(batteryHolderBolt), -0.05])
         cylinder(r = boltHoleDia(batteryHolderBolt)/2 + 0.25, h = mountThickness + 1);
        translate([(2 * boltCorners(batteryHolderBolt))/2, 2 * mountThickness + batteryWidth(batteryType) + boltCorners(batteryHolderBolt) + 2 * batClearance, -0.05])
         cylinder(r = boltHoleDia(batteryHolderBolt)/2 + 0.25, h = mountThickness + 1);
        
        //cut out for securing battery
        translate([-0.05, mountThickness, -0.05])
         cube([2 * boltCorners(batteryHolderBolt) + 1, batteryWidth(batteryType) + 2 * batClearance, batteryThickness(batteryType) + batClearance]);
    }
}

module BatteryHolderBack(type)
{
    translate([-batteryLength(type)/2 - batClearance - mountThickness, -batteryWidth(type)/2 - batClearance - mountThickness, 0]) 
     color(batteryHolderColour)
      difference()
    {
        union()
        {
            cube([mountThickness + 3 * boltCorners(batteryHolderBolt) + batClearance, batteryWidth(type) + 2 * (mountThickness + batClearance), batteryThickness(type) + mountThickness + batClearance]);
            //tabs for screws
            translate([0, -2 * boltCorners(batteryHolderBolt) + 0.05, 0])
             cube([mountThickness + 3 * boltCorners(batteryHolderBolt) + batClearance, 2 * boltCorners(batteryHolderBolt), mountThickness]);
            translate([0, batteryWidth(type) + 2 * (mountThickness + batClearance) - 0.05, 0])
             cube([mountThickness + 3 * boltCorners(batteryHolderBolt) + batClearance, 2 * boltCorners(batteryHolderBolt), mountThickness]);
        }
        
        //mounting holes
        translate([(mountThickness + 3 * boltCorners(batteryHolderBolt))/2, -boltCorners(batteryHolderBolt), -0.05])
         cylinder(r = boltHoleDia(batteryHolderBolt)/2 + 0.25, h = mountThickness + 1);
        translate([(mountThickness + 3 * boltCorners(batteryHolderBolt))/2, 2 * mountThickness + batteryWidth(batteryType) + boltCorners(batteryHolderBolt) + 2 * batClearance, -0.05])
         cylinder(r = boltHoleDia(batteryHolderBolt)/2 + 0.25, h = mountThickness + 1);
        
        //cut out for securing battery
        translate([mountThickness - batClearance, mountThickness, - 0.05])
         cube([3 * boltCorners(batteryHolderBolt) + batClearance + 1, batteryWidth(batteryType) + 2 * batClearance, batteryThickness(batteryType) + batClearance]);
    }
}

//template for the holes of the battery holder
module BatteryHolderHoles(type, boltType, holeDepth)
{
    //top left
    translate([-batteryLength(type)/2 - batClearance - mountThickness + (mountThickness + 3*boltCorners(batteryHolderBolt))/2, batteryWidth(type)/2 + batClearance + mountThickness + boltCorners(batteryHolderBolt), -0.5])
     cylinder(r = boltHoleDia(boltType)/2, h = holeDepth, $fn = 6);
    
    //top right
    translate([batteryLength(type)/2 - spTabLength - boltCorners(batteryHolderBolt), batteryWidth(type)/2 + batClearance + mountThickness + boltCorners(batteryHolderBolt), -0.5])
     cylinder(r = boltHoleDia(boltType)/2, h = holeDepth, $fn = 6);

    //bottom right
    translate([batteryLength(type)/2 - spTabLength - boltCorners(batteryHolderBolt), -(batteryWidth(type)/2 + batClearance + mountThickness + boltCorners(batteryHolderBolt)), -0.5])
     cylinder(r = boltHoleDia(boltType)/2, h = holeDepth, $fn = 6);
    
    //bottom left
    translate([-batteryLength(type)/2 - batClearance - mountThickness + (mountThickness + 3*boltCorners(batteryHolderBolt))/2, -(batteryWidth(type)/2 + batClearance + mountThickness + boltCorners(batteryHolderBolt)), -0.5])
     cylinder(r = boltHoleDia(boltType)/2, h = holeDepth, $fn = 6);
}

/*
BatteryHolderFront(batteryType);
BatteryHolderBack(batteryType);
Battery(batteryType);
BatteryHolderHoles(batteryType, M3Bolt, 10);
*/
