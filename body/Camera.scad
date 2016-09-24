include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>

cameraWidth =       58;
cameraHeight =      29.25;
cameraThickness =   16.25;
cameraAngle =       14; //degrees tilted downwards
cordHoleDia =       4;
cordDistFromSide =  9;
clipHeight =        9;
clipDistFromSide =  9.5;
clipDistFromBot =   5;
mountWidth =        tabLength + 5;

//calculated values
cameraBoxDepth = cameraThickness*cos(cameraAngle);
negClipBlockDip = sin(cameraAngle) * (mountThickness + 0.5);

//short mount to the left, has to make way for the clip
module CameraMountLeft()
{
    difference()
    {
        union()
        {
            //mounting tab
            cube([mountWidth,cameraBoxDepth + 2*mountThickness + tabLength, mountThickness]);
            
            rotate([0, 90, 0])
            minkowski()
            {
                //create the camera space
                rotate([0, -90, 0])
                 hull()
                {
                    translate([0,tabLength + mountThickness, 0])
                     cube([mountWidth,cameraBoxDepth * 0.85, mountThickness]);
                    //the shape of the rotated camera
                    translate([0, tabLength + mountThickness, cameraThickness*sin(cameraAngle) + mountThickness])
                     rotate([-cameraAngle, 0, 0])
                      cube([mountWidth, cameraThickness, cameraHeight]);
                }
                
                cylinder(r = mountThickness, h = 0.001);
            }
        }
        
        //hole for mounting bolt (offset it to allow room for the camera's cable and clip
        translate([tabLength/2, tabLength/2, -0.5])
         cylinder(r = boltHoleDia(mountHoleType)/2, h = mountThickness +1);
         
        //take the protrusion off the bottom
        translate([-0.5, -0.5, -mountThickness*2])
         cube([mountWidth + 1, tabLength + cameraBoxDepth + 2*mountThickness + 1, mountThickness*2]);
         
         //actual hole for the camera
        translate([mountThickness, tabLength + mountThickness, cameraThickness*sin(cameraAngle) + mountThickness])
         rotate([-cameraAngle, 0, 0])
          cube([mountWidth, cameraThickness, cameraHeight]);
          
         //slot for the clip
         translate([mountThickness + clipDistFromSide, tabLength + sin(cameraAngle) * (clipDistFromBot + negClipBlockDip + cameraThickness*sin(cameraAngle)), mountThickness + clipDistFromBot + negClipBlockDip + (cameraThickness + mountThickness)*sin(cameraAngle)])
          rotate([-cameraAngle, 0, 0])
           translate([0, -0.5, 0])
            cube([mountWidth, mountThickness + 1, clipHeight]);
    }   
}

//mount with the slot to allow the cable through
module CameraMountRight()
{
     difference()
    {
        union()
        {
            //mounting tab
            cube([mountWidth,cameraBoxDepth + 2*mountThickness + tabLength, mountThickness]);
            
            rotate([0, 90, 0])
            minkowski()
            {
                //create the camera space
                rotate([0, -90, 0])
                 hull()
                {
                    translate([0,tabLength + mountThickness, 0])
                     cube([mountWidth,cameraBoxDepth * 0.85, mountThickness]);
                    //the shape of the rotated camera
                    translate([0, tabLength + mountThickness, cameraThickness*sin(cameraAngle) + mountThickness])
                     rotate([-cameraAngle, 0, 0])
                      cube([mountWidth, cameraThickness, cameraHeight]);
                }
                
                cylinder(r = mountThickness, h = 0.001);
            }
        }
        
        //hole for mounting bolt (offset it to allow room for the camera's cable and clip
        translate([mountWidth - tabLength/2, tabLength/2, -0.5])
         cylinder(r = boltHoleDia(mountHoleType)/2, h = mountThickness +1);
         
        //take the protrusion off the bottom
        translate([-0.5, -0.5, -mountThickness*2])
         cube([mountWidth + 1, tabLength + cameraBoxDepth + 2*mountThickness + 1, mountThickness*2]);
         
         //actual hole for the camera
        translate([-mountThickness, tabLength + mountThickness, cameraThickness*sin(cameraAngle) + mountThickness])
         rotate([-cameraAngle, 0, 0])
          cube([mountWidth, cameraThickness, cameraHeight]);
          
         //slot for the cable
         translate([mountWidth - mountThickness - (cordDistFromSide + 1 + cordHoleDia/2) - cordDistFromSide + cordHoleDia/2, tabLength + sin(cameraAngle) * (cameraHeight/2 + negClipBlockDip + cameraThickness*sin(cameraAngle) - cordHoleDia/2), mountThickness + cos(cameraAngle)*(cameraHeight/2) + (cameraThickness + mountThickness)*sin(cameraAngle) - cordHoleDia/2])
          rotate([-cameraAngle, 0, 0])
           translate([0, -0.5, 0])
            cube([cordDistFromSide + 1 + cordHoleDia/2, mountThickness + 1, cordHoleDia]);
    }   
}

module CameraMountVisualisation()
{
    translate([0, -(cameraBoxDepth + 2*mountThickness + tabLength), 0])
    {
        color(cameraMountColour)
         translate([cameraWidth/2 - mountWidth + mountThickness, 0, 0])
          CameraMountRight(false);

        color(cameraMountColour)
         translate([-mountThickness -cameraWidth/2, 0, 0])
          CameraMountLeft();
        
        //a crude model of the Camera
        color(cameraColour)
         translate([-cameraWidth/2, tabLength + mountThickness, cameraThickness*sin(cameraAngle) + mountThickness])
          rotate([-cameraAngle, 0, 0])
           cube([cameraWidth, cameraThickness, cameraHeight]);
    }
}

module CameraMountingHoleTemplate(holeDepth)
{
    translate([0, -(cameraBoxDepth + 2*mountThickness + tabLength), 0])
    {
        //left mount
        translate([-cameraWidth/2 - mountThickness + tabLength/2, tabLength/2,0])
         cylinder(r = boltHoleDia(mountHoleType)/2 + 0.25, h = holeDepth);
         
        //right mount
        translate([cameraWidth/2 + mountThickness - tabLength/2, tabLength/2,0])
         cylinder(r = boltHoleDia(mountHoleType)/2 + 0.25, h = holeDepth);
    }
}

//generate models for printing

/*
translate([-47, 35, mountWidth])
 rotate([0, 90, 0])
  CameraMountRight();
  
rotate([0, -90, 0])
 CameraMountLeft();
 */
 


/*
CameraMountVisualisation();

CameraMountingHoleTemplate(plateThickness + 1);
*/



