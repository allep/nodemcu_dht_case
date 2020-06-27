//------------------------------------------------
// 1 - body of the NodeMCU + DHT22 box
//
// author: Alessandro Paganelli 
// e-mail: alessandro.paganelli@gmail.com
// github: https://github.com/allep
// 
// Description
// This case is designed to be used with a NodeMCU 
// Amica ESP-8266 board and a DHT22 temperature
// and humidity sensor.
//
// All sizes are expressed in mm.
//------------------------------------------------

// Set face number to a sufficiently high number.
$fn = 30;

//------------------------------------------------
// Variables

//------------------------------------------------
// Box

// Inner sizes: outer size will be increased by
// the wall thickness.
Z_LEN = 21;

WALL_THICKNESS = 1.2;
BASE_THICKNESS = 2;

CYLINDER_THICKNESS = 1.2;

// For M3 screws it must be 1.5 mm + 5% tolerance
CYLINDER_RADIUS = 1.575;

// tolerances
X_GAP = 1.0;
Y_GAP = 1.0;

//------------------------------------------------
// Board size
BOARD_THICKNESS = 1.2;
BOARD_HEIGHT = 5; // including clearence

// Based on NodeMCU Amica ESP-8266 board.
SCREW_DISTANCE_Y = 43.6;
SCREW_DISTANCE_X = 20.9;

// Usb size
// Note: to be quite sure that any USB cable can fit
// here we create a hole quite large (height > 
// BOARD_HEIGHT)
// Adjust it based on your needs.
Z_USB_PORT_HEIGHT = 7;
X_USB_PORT_LEN = 11;

//------------------------------------------------
// DHT22

X_SENSOR_LEN = 15;
Y_SENSOR_LEN = 20;
X_SENSOR_GAP = 0.5;
Y_SENSOR_GAP = 0.5;

// Used to keep track of the pins that need some
// clearance to allow cables to be connected.
Y_SENSOR_DISPLACEMENT = 5;

// Peg
SENSOR_PEG_RADIUS = 1.25;
Y_SENSOR_PEG_DISTANCE = 1.8;
Z_SENSOR_PEG_HEIGHT = 3.0;

//------------------------------------------------
// Screw sizes (M3)

Z_SCREW_LEN = 19;
Z_SCREW_HEAD_LEN = 3.5;

//------------------------------------------------
// Actual script

// First compute sizes
x_len_inner = SCREW_DISTANCE_X + 2*(CYLINDER_RADIUS + CYLINDER_THICKNESS + X_GAP - WALL_THICKNESS);
y_len_inner = SCREW_DISTANCE_Y + 2*(CYLINDER_RADIUS + CYLINDER_THICKNESS + Y_GAP - WALL_THICKNESS);
x_len_outer = x_len_inner + 2*WALL_THICKNESS;
y_len_outer = y_len_inner + 2*WALL_THICKNESS;

// actual box
difference() {
    // the box
    difference() {
        cube([x_len_outer, y_len_outer, Z_LEN + BASE_THICKNESS]);
        translate([WALL_THICKNESS, WALL_THICKNESS, BASE_THICKNESS])
        cube([x_len_inner, y_len_inner, Z_LEN]);
    }
    // the sensor hole
    translate([x_len_outer/2 - X_SENSOR_LEN/2 - X_SENSOR_GAP, y_len_outer/2 - Y_SENSOR_LEN/2 - Y_SENSOR_GAP + Y_SENSOR_DISPLACEMENT, 0])
    cube([X_SENSOR_LEN + 2*X_SENSOR_GAP, Y_SENSOR_LEN + 2*Y_SENSOR_GAP, BASE_THICKNESS]);
    // the usb port hole
    translate([x_len_outer/2 - X_USB_PORT_LEN/2, 0, Z_LEN + BASE_THICKNESS - Z_USB_PORT_HEIGHT])
    cube([X_USB_PORT_LEN, WALL_THICKNESS, Z_USB_PORT_HEIGHT]);
}

// screw cylinders
for (j = [0:1]) {
    for ( i = [0:1] ) {
        // compute the shift needed
        shift_x = i*SCREW_DISTANCE_X + CYLINDER_THICKNESS + CYLINDER_RADIUS + X_GAP;
        shift_y = j*SCREW_DISTANCE_Y + CYLINDER_THICKNESS + CYLINDER_RADIUS + Y_GAP;
        shift_z = BASE_THICKNESS;
        translate([shift_x, shift_y, shift_z])
        difference() {
            cylinder(h = Z_LEN-BOARD_HEIGHT, r = CYLINDER_RADIUS + CYLINDER_THICKNESS);
            cylinder(h = Z_LEN-BOARD_HEIGHT, r = CYLINDER_RADIUS);
        }
    }
}

// sensor peg
translate([x_len_outer/2, y_len_outer/2 + Y_SENSOR_LEN/2 + Y_SENSOR_GAP + Y_SENSOR_DISPLACEMENT + Y_SENSOR_PEG_DISTANCE, BASE_THICKNESS])
cylinder(h = Z_SENSOR_PEG_HEIGHT, r = SENSOR_PEG_RADIUS);
