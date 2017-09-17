include <params.scad>

inch = 25.4;
unit = 19.05;
x = [1, 0, 0];
y = [0, 1, 0];
z = [0, 0, 1];

// roundnessness radius at side
roundness = 10;

block_size = [297, 210, 24];
lip_width = (block_size[0]-plate_size[0]) / 2;
layout_pos = [lip_width, block_size[1] - plate_size[1] - lip_width];

mounting_hole_pos = [
    [0.375*unit, 1.5*unit],
    [14.375*unit, 3.5*unit],
    [9.5*unit, 0.5*unit],
    [3.5*unit, 0.5*unit],
    [3.75*unit, 4*unit],
    [8.625*unit, 3*unit],
];

// maximum distance from top of your keyboard to switch mount surface.
lip_depth = 7.5;

module invert_2D()
{
    difference() {
        block_profile();
        children();
    }
}

module mirrored(d) {
    children();
    mirror(d) children();
}

module block_profile()
{
    hull()
    {
        translate([1, 1]*roundness) circle(r=roundness);
        translate(block_size[0]*x + [-1, 1]*roundness) circle(r=roundness);
        translate(block_size[1]*y + [1, -1]*roundness) circle(r=roundness);
        translate(block_size + [-1, -1]*roundness) circle(r=roundness);
    }
}
