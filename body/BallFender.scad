include <ParametricValues.scad>
include <Fasteners.scad>
include <Colours.scad>

fenderHeightTotal = 		fenderDrop + fenderHeight + plateThickness;
pillarTabWallThickness = 	5;

module BallFender()
{
	color(ballFenderCol)
	intersection()
	{
		difference()
		{
			union()
			{
				difference()
				{
					union()
					{
						cylinder(r = ballBiteRadius, h = fenderHeightTotal);
						translate([0, 0, fenderDrop + plateThickness])
						 cylinder(r = ballBiteRadius + 2 * fenderThickness, h =  2 * fenderThickness);
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
			}
		
			//allow clearance for the plate on the bottom
			difference()
			{	
				translate([0, -ballBiteRadius, -0.01])
				 cube([ballBiteRadius *2, ballBiteRadius *2, fenderDrop + plateThickness]);
			
				translate([0, 0, -0.5])
				 cylinder(r = ballBiteRadius, h = fenderDrop + plateThickness + 0.5);
			}	
		}
		
		//cut off ends of wings so that the robot fits within size limit
		translate([ballBiteRadius + bodyRadius - ballBiteIndent, 0, 0])
		 cylinder(r = bodyRadius, h = fenderHeightTotal);
	}
}


//translate([60, 0, 75/2 - 15])
// sphere(r = 75/2);
//BallFender();
