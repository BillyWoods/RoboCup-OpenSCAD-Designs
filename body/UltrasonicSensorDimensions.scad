
//define some standard ultrasonic sensor sizes and functions for getting dimensions


//
//ULTRASONIC SENSORS
//
			//[dist transducers, transducer dia, transducer height, board thickness, board height, board width]
HCSR04 =      [25.7, 16, 12.2, 1.6, 20.5, 45.5];

//
//FUNCTIONS FOR GETTING DIMENSIONS
//

function USTransducerSpacing(type) = 	type[0];
function USTransducerDia(type) = 		type[1];
function USTransducerHeight(type) = 	type[2];
function USBoardThickness(type) = 	 	type[3];
function USBoardHeight(type) = 			type[4];
function USBoardWidth(type) = 			type[5];