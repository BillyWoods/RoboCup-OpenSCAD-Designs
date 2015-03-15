include <ParametricValues.scad>
use     <Fasteners.scad>

module Pillars(showNutsWashers = false, printToBOM = false)
{
	pillarLength = distPlateMB + distPlateTM + plateThickness + 2*pillarProtrusion;
	
	for(i=[0:numPillars-1]) 
	{
		if(i == frontPillar) //the offset pillar which makes way for the bite
		{
			rotate([0,0,i*(360/numPillars)])
			 translate([0, bodyRadius - distPillarToEdge - frontPillarOffset,-pillarProtrusion])
			  union()
			  {
				  ThreadedRod(pillarType, pillarLength, printToBOM);
				  
				  if(showNutsWashers == true)
				  {
					  //
					  //bottom plate underside
					  //
					  translate([0,0, pillarProtrusion - washerThickness(pillarWasherType)])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion - washerThickness(pillarWasherType) - nutThickness(pillarNutType)])
					   Nut(pillarNutType, printToBOM);
					   
					  //bottom plate top side
					  translate([0,0, pillarProtrusion + plateThickness + 2 * fenderThickness])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + plateThickness + 2 * fenderThickness])
					   Nut(pillarNutType, printToBOM);
					   
					  //
					  //middle plate underside
					  //
					  translate([0,0, pillarProtrusion + distPlateMB - washerThickness(pillarWasherType)])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + distPlateMB - washerThickness(pillarWasherType) - 
								nutThickness(pillarNutType)])
					   Nut(pillarNutType, printToBOM);
					   
					  //middle plate top side
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB])
					   Nut(pillarNutType, printToBOM);
					   
					  //
					  //top plate underside
					  //
					  translate([0,0, pillarProtrusion + distPlateMB + distPlateTM - 
								washerThickness(pillarWasherType)])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + distPlateMB + distPlateTM - 
								washerThickness(pillarWasherType) - nutThickness(pillarNutType)])
					   Nut(pillarNutType, printToBOM);
					   
					  //top plate top side
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB + distPlateTM])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB + distPlateTM])
					   Nut(pillarNutType, printToBOM);
				  }
			  }
		  }
		  
		  else
		  {
			rotate([0,0,i*(360/numPillars)])
			 translate([0, bodyRadius - distPillarToEdge,-pillarProtrusion])
			  union()
			  {
				  ThreadedRod(pillarType, pillarLength, printToBOM);
				  
				  if(showNutsWashers == true)
				  {
					  //
					  //bottom plate underside
					  //
					  translate([0,0, pillarProtrusion - washerThickness(pillarWasherType)])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion - washerThickness(pillarWasherType) - nutThickness(pillarNutType)])
					   Nut(pillarNutType, printToBOM);
					   
					  //bottom plate top side
					  translate([0,0, pillarProtrusion + plateThickness])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + plateThickness])
					   Nut(pillarNutType, printToBOM);
					   
					  //
					  //middle plate underside
					  //
					  translate([0,0, pillarProtrusion + distPlateMB - washerThickness(pillarWasherType)])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + distPlateMB - washerThickness(pillarWasherType) - 
								nutThickness(pillarNutType)])
					   Nut(pillarNutType, printToBOM);
					   
					  //middle plate top side
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB])
					   Nut(pillarNutType, printToBOM);
					   
					  //
					  //top plate underside
					  //
					  translate([0,0, pillarProtrusion + distPlateMB + distPlateTM - 
								washerThickness(pillarWasherType)])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + distPlateMB + distPlateTM - 
								washerThickness(pillarWasherType) - nutThickness(pillarNutType)])
					   Nut(pillarNutType, printToBOM);
					   
					  //top plate top side
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB + distPlateTM])
					   Washer(pillarWasherType, printToBOM);
					  translate([0,0, pillarProtrusion + plateThickness + distPlateMB + distPlateTM])
					   Nut(pillarNutType, printToBOM);
				  }
			  }
		}
	}
}

module PillarHoleTemplate(pilLength)
{
	for(i = [0:numPillars-1])
	{
		if(i == frontPillar) //the one offset pillar to make way for the ball bite
		{
			rotate([0, 0, i*(360/numPillars)])
			 translate([0, bodyRadius - distPillarToEdge - frontPillarOffset, 0])
			  cylinder(r = threadDia(pillarType)/2 + 0.5, h = pilLength);
		}
		
		else
		{
			rotate([0, 0, i*(360/numPillars)])
			 translate([0, bodyRadius - distPillarToEdge, 0])
			  cylinder(r = threadDia(pillarType)/2 + 0.5, h = pilLength);
		}
	}
}
