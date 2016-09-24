//
//IR Sensor dimensions
//

// for round IRs 
//[shape, diameter, length, flange diameter, flange thickness, legLength, legSpacing]
3mmIR =     ["ROUND", 3, 4.5, 3.75, 1, 18, 2.54];
5mmIR =     ["ROUND", 5, 7.6, 6   , 1, 28, 2.54];

// for square shaped IRs
// [shape, width, height, depth, dome radius, leg length, leg spacing, 
//  leg distance from back of sensor, dome distance from top]
TSOP348xx = ["SQUARE", 6.2, 6.9, 4, 2.5, 24, 2.54, 1.5, 3];

// --------------------------------
// functions for getting dimensions
// --------------------------------
function IRShape(type) =            type[0];

// for round IRs
function IRRadius(type) =           type[1]/2;
function IRLength(type) =           type[2];
function IRFlangeRadius(type) =     type[3]/2;
function IRFlangeThickness(type) =  type[4];

// for square-shaped IRs
function IRWidth(type) =            type[1];
function IRHeight(type) =           type[2];
function IRDepth(type) =            type[3];
function IRDomeRad(type) =          type[4];
function IRLegPosition(type) =      type[7];
function IRDomePosition(type) =     type[9];

function IRLegLength(type) =        type[5];
function IRLegSpacing(type) =       type[6];
