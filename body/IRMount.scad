include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>
include <IRSensorDimensions.scad>

//print tuning values
IRLegAdj		 = 0.6;
IRIndentDiaAdj 	 = 0.6;
mBoltDiaAdj		 = 0.5;

module IRSensor(type)
{
	color(photoDiodeColour)
	 union()
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
		translate([legSpacing(type)/2 - 0.15 - IRLegAdj/2, -0.15 - IRLegAdj/2, -legLength(type)])
		 cube([0.3 + IRLegAdj, 0.3 + IRLegAdj, legLength(type)]);
		translate([-(legSpacing(type)/2 + 0.15 + IRLegAdj/2), -0.15 - IRLegAdj/2, -legLength(type)])
		 cube([0.3 + IRLegAdj, 0.3 + IRLegAdj, legLength(type)]);
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
//IRSensor(5mmIR);
//IRMount(5mmIR);
