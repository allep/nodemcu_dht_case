//------------------------------------------------
// 2 - base of the NodeMCU + DHT22 box
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
// Hat

WALL_THICKNESS = 1.2;
BASE_THICKNESS = 1.2;
BASE_THICKNESS_SCREWS = 4.7;

CYLINDER_THICKNESS = 1.2;

// For M3 screws it must be 1.5 mm + 5% tolerance
CYLINDER_RADIUS = 1.575;
CYLINDER_HEIGHT = 3;

// tolerances
X_GAP = 1.0;
Y_GAP = 1.0;

//------------------------------------------------
// Board size
BOARD_THICKNESS = 2.0;

// Based on NodeMCU Amica ESP-8266 board.
SCREW_DISTANCE_Y = 43.6;
SCREW_DISTANCE_X = 20.9;

//------------------------------------------------
// Screw sizes (M3)

Z_SCREW_LEN = 19;
Z_SCREW_HEAD_LEN = 3.5;
SCREW_HEAD_RADIUS = 2.75;
SCREW_HEAD_RADIUS_GAP = 0.1;

//------------------------------------------------
// Actual script

// First compute sizes
// Note: these must match with those of 01_body.scad
x_len_outer = SCREW_DISTANCE_X + 2*(CYLINDER_RADIUS + CYLINDER_THICKNESS + X_GAP);
y_len_outer = SCREW_DISTANCE_Y + 2*(CYLINDER_RADIUS + CYLINDER_THICKNESS + Y_GAP);

x_screw_head_base = 2*(CYLINDER_THICKNESS + CYLINDER_RADIUS + X_GAP);

// Now compute inner sizes
y_len_inner = y_len_outer - 2*x_screw_head_base;
x_len_inner = x_len_outer - 2*WALL_THICKNESS;
z_len_inner = BASE_THICKNESS_SCREWS - BASE_THICKNESS;

echo("Computed X len = ", x_len_outer, " and Y len = ", y_len_outer);
echo("Computed screw head base = ", x_screw_head_base);

difference() {
    union()
    {
        difference() {
            cube([x_len_outer, y_len_outer, BASE_THICKNESS_SCREWS]);
            translate([WALL_THICKNESS, x_screw_head_base, BASE_THICKNESS])
            cube([x_len_inner, y_len_inner, z_len_inner]);
        }

        // screw cylinders (without screw actual hole)
        for (j = [0:1]) {
            for ( i = [0:1] ) {
                // compute the shift needed
                shift_x = i*SCREW_DISTANCE_X + CYLINDER_THICKNESS + CYLINDER_RADIUS + X_GAP;
                shift_y = j*SCREW_DISTANCE_Y + CYLINDER_THICKNESS + CYLINDER_RADIUS + Y_GAP;
                shift_z = BASE_THICKNESS_SCREWS;
                translate([shift_x, shift_y, shift_z])
                cylinder(h = CYLINDER_HEIGHT, r = CYLINDER_RADIUS + CYLINDER_THICKNESS);
            }
        }
    }
    // screw head holes
    for (j = [0:1]) {
        for ( i = [0:1] ) {
            // compute the shift needed
            shift_x = i*SCREW_DISTANCE_X + CYLINDER_THICKNESS + CYLINDER_RADIUS + X_GAP;
            shift_y = j*SCREW_DISTANCE_Y + CYLINDER_THICKNESS + CYLINDER_RADIUS + Y_GAP;
            shift_z = 0;
            translate([shift_x, shift_y, shift_z])
            cylinder(h = Z_SCREW_HEAD_LEN, r = SCREW_HEAD_RADIUS + SCREW_HEAD_RADIUS_GAP);
        }
    }
    // actual screw holes
    for (j = [0:1]) {
        for ( i = [0:1] ) {
            // compute the shift needed
            shift_x = i*SCREW_DISTANCE_X + CYLINDER_THICKNESS + CYLINDER_RADIUS + X_GAP;
            shift_y = j*SCREW_DISTANCE_Y + CYLINDER_THICKNESS + CYLINDER_RADIUS + Y_GAP;
            shift_z = 0;
            translate([shift_x, shift_y, shift_z])
            cylinder(h = BASE_THICKNESS_SCREWS + CYLINDER_HEIGHT, r = CYLINDER_RADIUS);
        }
    }
}
