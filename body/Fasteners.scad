include <Colours.scad>

//
//CODE FOR BOLTS    
//

//define some standard bolt dimensions
// [ name on BOM, bolt diameter, hex head thickness, width of head measured between corners]
M3Bolt = ["M3 bolt", 3, 2.3,   6];
M4Bolt = ["M4 bolt", 4,   3, 7.7];
M5Bolt = ["M5 bolt", 5, 4.5, 8.8];
M6Bolt = ["M6 bolt", 6,   5,  11];

//functions for quickly getting bolt dimensions, etc.
function boltName(type) =          type[0];
function boltHoleDia(type) =       type[1];
function boltHeadThickness(type) = type[2];
function boltCorners(type) =       type[3];

module Bolt(type, length, printToBOM = false)
{
    color(boltColour)
     union()
     {
         //hexagonal head shape (cylinder limited to 6 side segments)
         cylinder(r = boltCorners(type)/2, h = boltHeadThickness(type), $fn = 6);
         //the bolt shank
         translate([0,0,-length])
          cylinder(r = boltHoleDia(type)/2, h = length + 0.1);
     }
    
    //echoes properties to command line, etc. so it can be counted manually
    //or by a program
    if(printToBOM == true)
    {
        echo(boltName(type), "x", length);
    }
}



//
//CODE FOR NUTS 
//

//define some standard nut dimensions
// [ nut name on BOM, hole diameter, nut thickness, width measured between corners, width between flats]
M3Nut = ["M3 nut", 3, 2.3, 6.1, 5.3];
M4Nut = ["M4 nut", 4,   3, 7.7,   0];
M5Nut = ["M5 nut", 5, 4.5, 8.8,   0];
M6Nut = ["M6 nut", 6,   5,  11,   0];

//functions for quickly getting nut dimensions
function nutName(type) =      type[0];
function nutHoleDia(type) =   type[1];
function nutThickness(type) = type[2];
function nutCorners(type) =   type[3];
function nutFlats(type) =     type[4];

module Nut(type, printToBOM = false, negShape = false)
{
    color(nutColour)
     difference()
     {
         //hexagonal shape (cylinder limited to 6 side segments)
         cylinder(r = nutCorners(type)/2, h = nutThickness(type), $fn = 6);
        
         //allows for a nut to be generated which is useful for being a negative in other 
         //difference operations down the track
         if(negShape == false) 
         {
             //the hole through the centre
             translate([0,0,-0.05])
              cylinder(r = nutHoleDia(type)/2, h = nutThickness(type) + 0.1);
         }
     }
    
    //echoes properties to command line, etc. so it can be counted manually
    //or by a program
    if(printToBOM == true)
    {
        echo(nutName(type));
    }
}




//
//CODE FOR WASHERS
//

//define some standard washers
// [washer name, inner hole diameter, outer diameter, thickness]
M3Washer = ["M3 washer", 3.3,  6.8, 0.5];
M4Washer = ["M4 washer", 4.4,  8.8, 0.8];
M5Washer = ["M5 washer", 5.4,  9.8,   1];
M6Washer = ["M6 washer", 6.5, 11.8, 1.6];

//functions for quickly getting washer dimensions
function washerName(type) =        type[0];
function washerID(type) =          type[1];
function washerOD(type) =          type[2];
function washerThickness(type) =   type[3];

module Washer(type, printToBOM = false, negShape = false)
{
    color(washerColour)
     difference()
     {
         //main circle shape
         cylinder(r = washerOD(type)/2, h = washerThickness(type));
        
         //allows for a washer to be generated which is useful for being a negative in other 
         //difference operations down the track
         if(negShape == false) 
         {
             //the hole through the centre
             translate([0,0,-0.05])
              cylinder(r = washerID(type)/2, h = washerThickness(type) + 0.1);
         }
     }
    
    //echoes properties to command line, etc. so it can be counted manually
    //or by a program
    if(printToBOM == true)
    {
        echo(washerName(type));
    }
}




//
//CODE FOR THREADED ROD
//

//define some standard dimensions and properties
// [name on BOM, rod diameter]
M3Threaded = ["M3 threaded rod", 3];
M4Threaded = ["M4 threaded rod", 4];
M5Threaded = ["M5 threaded rod", 5];
M6Threaded = ["M6 threaded rod", 6];

//functions for quickly getting bolt dimensions
function threadName(type) =   type[0];
function threadDia(type) =    type[1];

module ThreadedRod(type, length, printToBOM = false)
{
    color(threadedRodColour)
     cylinder(r = threadDia(type)/2, h = length);
    
    //echoes properties to command line, etc. so it can be counted manually
    //or by a program
    if(printToBOM == true)
    {
        echo(threadName(type), "x", length);
    }
}
