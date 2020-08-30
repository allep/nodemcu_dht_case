# NodeMCU DHT Case
A simple 3d printable case for NodeMCU board plus a DHT22 temperature and humidity sensor.
It is licensed under `GPL-3.0-or-later` license.

# Introduction
This case was designed considering NodeMCU Amica ESP-8266 boards in mind, connected to a DHT22 temperature and humidity sensor.

# Source code
[OpenSCAD](https://www.openscad.org/) source code can be found under `src` directory.
It was written to be fully customizable and it can be adapted to other boards and sensors as well.

## Debug mode
In order to validate the design it is possible to enable a debug mode inside OpenSCAD by setting `DEBUG_MODE = 1` inside the source files.
This will simulate the actual position of the screws in order to let you to double check if their position is what you expect.
