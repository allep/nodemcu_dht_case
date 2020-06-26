//------------------------------------------------
// 1 - body of the NodeMCU + DHT22 box
//
// author: Alessandro Paganelli 
// e-mail: alessandro.paganelli@gmail.com
// github: https://github.com/allep
//------------------------------------------------

// Set face number to a sufficiently high number.
$fn = 30;

//------------------------------------------------
// Variables

//------------------------------------------------
// Box

// Inner sizes: outer size will be increased by
// the wall thickness.
X_LEN = 33; // mm
Y_LEN = 60; // mm
Z_LEN = 21; // mm

WALL_THICKNESS = 2; // mm
BASE_THICKNESS = 2; // mm

CYLINDER_THICKNESS = 2.5; // mm

// For M3 screws it must be 1.5 mm + 10% tolerance
CYLINDER_RADIUS = 1.65; // mm

// tolerances
X_GAP = 1.25; // mm
Y_GAP = 1.25; // mm

//------------------------------------------------
// Board size
BOARD_THICKNESS = 2; // mm
BOARD_HEIGHT = 5; // mm, including clearence

SCREW_DISTANCE_Y = 43; // mm
SCREW_DISTANCE_X = 20; // mm

Z_USB_PORT_HEIGHT = BOARD_HEIGHT;
X_USB_PORT_LEN = 9; // mm

//------------------------------------------------
// DHT22

X_SENSOR_LEN = 15; // mm
Y_SENSOR_LEN = 20; // mm
X_SENSOR_GAP = 0.5; // mm
Y_SENSOR_GAP = 0.5; // mm

//------------------------------------------------
// Screw sizes (M3)

Z_SCREW_LEN = 19; // mm
Z_SCREW_HEAD_LEN = 3.5; // mm

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
    translate([x_len_outer/2 - X_SENSOR_LEN/2 - X_SENSOR_GAP, y_len_outer/2 - Y_SENSOR_LEN/2 - Y_SENSOR_GAP, 0])
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
