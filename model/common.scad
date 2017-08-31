include <params.scad>

inch = 25.4;
unit = 19.05;
x = [1, 0, 0];
y = [0, 1, 0];
z = [0, 0, 1];

// roundnessness radius at side
roundness = 5;

block_size = [297, 210, 20];
layout_size = [14, 5] * unit;
layout_pos = [(block_size[0]-layout_size[0]) / 2, block_size[1] - layout_size[1] - 15];

// maximum distance from top of your keyboard to switch mount surface.
lip_depth = 7.5;

module invert_2D()
{
    difference() {
        translate([xmin(), ymin()]) square([block_size[0], block_size[1]]);
        children();
    }
}

module mirrored(d) {
    children();
    mirror(d) children();
}
