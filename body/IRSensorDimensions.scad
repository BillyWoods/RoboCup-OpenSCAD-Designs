//
//IR Sensor dimensions
//
//[diameter, length, flange diameter, flange thickness, legLength, legSpacing]
3mmIR = 	[3, 4.5, 3.75, 1, 18, 2.54];
5mmIR = 	[5, 7.6, 6   , 1, 28, 2.54];


//functions for getting dimensions
function IRRadius(type) = 			type[0]/2;
function IRLength(type) = 			type[1];
function IRFlangeRadius(type) = 	type[2]/2;
function IRFlangeThickness(type) =	type[3];
function legLength(type) = 	 		type[4];
function legSpacing(type) = 		type[5];