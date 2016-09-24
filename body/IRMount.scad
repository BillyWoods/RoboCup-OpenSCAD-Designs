include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>
include <IRSensorDimensions.scad>

//print tuning values
IRLegAdj         = 0.6;
IRIndentDiaAdj   = 0.6;
mBoltDiaAdj      = 0.5;

module IRSensor(type, isNegative = false)
{
    color(photoDiodeColour)
     union()
    {   
        if(IRShape(type) == "ROUND")
        {
            //flange
            cylinder(r = IRFlangeRadius(type), h = IRFlangeThickness(type), $fs = 1);
        
            //main cylindrical body
            translate([0, 0, IRFlangeThickness(type) - 0.01])
             cylinder(r = IRRadius(type), h = IRLength(type) - IRRadius(type), $fs = 1);
            
            //dome cap
            translate([0, 0, IRLength(type) + IRFlangeThickness(type) - IRRadius(type)])
             sphere(r = IRRadius(type), $fn = 10);
             
            //legs
            translate([IRLegSpacing(type)/2 - 0.15 - IRLegAdj/2, -0.15 - IRLegAdj/2, -IRLegLength(type)])
             cube([0.3 + IRLegAdj, 0.3 + IRLegAdj, IRLegLength(type)]);
            translate([-(IRLegSpacing(type)/2 + 0.15 + IRLegAdj/2), -0.15 - IRLegAdj/2, -IRLegLength(type)])
             cube([0.3 + IRLegAdj, 0.3 + IRLegAdj, IRLegLength(type)]);
        }

        else if (IRShape(type) == "SQUARE")
        {
            // square body
            translate([-IRWidth(type)/2, -IRDepth(type), 0])
             cube([IRWidth(type), IRDepth(type), IRHeight(type)]);
            
            // dome
            if(!isNegative)
            {
                translate([0, -0.2*IRDomeRad(type), IRHeight(type)-IRDomeRad(type)])
                 sphere(r= IRDomeRad(type));
            }
            else
            {
                // for the negative, replace the dome with a thicker front
                //cube();
            }

            rotate([0, 0, 180])
             for (i=[-1:1])
            {
                translate([i * IRLegSpacing(type) - 0.6/2, IRDepth(type)*0.65, -2.45])
                {
                    // root of legs
                    cube([0.6, 0.4, 2.5]);
                    // bent part of legs
                    cube([0.6, IRLegLength(type) - 2.5, 0.4]);
                }
            }
        }
    }
}

module IRMount(IRType)
{
    color(IRMountColour)
     union()
    {
        //screw tab
        difference()
        {
            hull()
            {
                //screw tab
                cylinder(r = boltHoleDia(IRSensorBolt), h = mountThickness);
                translate([0, -boltHoleDia(IRSensorBolt), 0])
                 cube([boltHoleDia(IRSensorBolt), boltHoleDia(IRSensorBolt) * 2, 4]);
            }
            
            //hole for bolt
            translate([0, 0, -0.5])
             cylinder(r = (boltHoleDia(IRSensorBolt) + mBoltDiaAdj)/2, h = mountThickness + 1);
        }

        if(IRShape(IRType) == "ROUND")
        {
            //IR mount
            difference()
            {
                //cube-shaped IR mounting block
                translate([boltHoleDia(IRSensorBolt) - 0.01, -boltHoleDia(IRSensorBolt), 0])
                 cube([IRFlangeRadius(IRType) * 2 + mountThickness, boltHoleDia(IRSensorBolt) * 2, IRFlangeRadius(IRType) * 2 + mountThickness]);
                
                //hole for IR sensor
                translate([boltHoleDia(IRSensorBolt) + IRFlangeRadius(IRType) + mountThickness/2, 0, IRFlangeRadius(IRType) + mountThickness/2])
                 rotate([-90, 0, 0])
                  cylinder(r = IRFlangeRadius(IRType) + IRIndentDiaAdj/2, h = boltHoleDia(IRSensorBolt) + 1, $fs = 1);
                
                //use IR sensor diff to get leg holes
                translate([boltHoleDia(IRSensorBolt) + IRFlangeRadius(IRType) + mountThickness/2, 0, IRFlangeRadius(IRType) + mountThickness/2])
                 rotate([-90, 0, 0])
                  IRSensor(IRType);
            }
        }
        else if (IRShape(IRType) == "SQUARE")
        {
            //IR mount
            difference()
            {
                //cube-shaped IR mounting block
                translate([boltHoleDia(IRSensorBolt) - 0.01, -boltHoleDia(IRSensorBolt), 0])
                 cube([IRWidth(IRType) + mountThickness, IRDepth(IRType) + IRDomeRad(IRType) + mountThickness + 1, IRHeight(IRType) + mountThickness/2]);
                
                // slit for light to enter
                translate([boltHoleDia(IRSensorBolt) + (IRWidth(IRType) + mountThickness)/2 - 1/2, 5, -0.05])
                  cube([1, mountThickness, 2.5 * IRDomeRad(IRType)]);
                
                // make a slot for IR sensor
                translate([boltHoleDia(IRSensorBolt) + (IRWidth(IRType) + mountThickness)/2, (IRDepth(IRType) + IRDomeRad(IRType) + mountThickness)/2 - boltHoleDia(IRSensorBolt), IRHeight(IRType)/2])
                 scale([1.10,1.10,1.10])
                  cube([IRWidth(IRType), IRDepth(IRType) + IRDomeRad(IRType),IRHeight(IRType)], center = true);

                // hole for legs
                translate([boltHoleDia(IRSensorBolt) + (IRWidth(IRType) + mountThickness)/2, (IRDepth(IRType) + mountThickness)/2 - boltHoleDia(IRSensorBolt) - IRDepth(IRType)*0.15, IRHeight(IRType) + mountThickness/2 - 0.05])
                 cube([IRWidth(IRType), 1, mountThickness], center = true);
            }

        }
    }
}

module IRAssembly()
{
    if (IRShape(IRSensor) == "SQUARE")
    {
        translate([0, 0, -1.5])
         rotate([0, 180, 8])
        {
            translate([boltHoleDia(IRSensorBolt) + (mountThickness + IRWidth(IRSensor))/2, boltHoleDia(IRSensorBolt) + 0.3, IRHeight(IRSensor)])
             rotate([0,180,0])
              IRSensor(IRSensor);
            IRMount(IRSensor);
        }
    }
    else if (IRShape(IRSensor) == "ROUND")
    {
        IRMount(IRSensor);
    }
}

//some misc dimensions used outside this scad. Do not change
IRholeOffset = boltHoleDia(IRSensorBolt) + IRFlangeRadius(IRSensor) + mountThickness/2; //distance offset in the x between mounting hole and IR

module IRholeTemplate()
{
    for(i = [0:numIRSensor-1])
    {
        rotate([0, 0, i * (360/numIRSensor)])
         translate([0,bodyRadius - IRSensorDistEdge,0])
          cylinder(r = boltHoleDia(IRSensorBolt)/2, h = plateThickness + 1);
    }
}

//IRholeTemplate();

//for printing
//IRMount(IRSensor);
