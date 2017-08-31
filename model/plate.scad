include <common.scad>
use <top_cutout.scad>
/* use <base.scad> */

difference()
{
    translate(-layout_pos)
    top_cutout_2D();
    plate_2D();
}

module stabil() {
    translate([0, -0.03]*inch) {
        square([0.13, 0.55]*inch, true);
        mirrored(y) translate((0.55*inch-2)/2*y) square([0.13*inch+1, 2], true);
    }
}
module switch() {
    hole_x = 15.5;
    hole_y = 12.8; 
    drill_d = 1.5;
    square([hole_x, hole_y], true);
    mirrored(x) translate((hole_x-drill_d)/2*x) square([drill_d, hole_y+drill_d], true);
}

module plate_cutout(u) {
    if (u == 6)  translate(0.5*unit*x) switch();
    else         switch();

    A = (u == 6)                ? 3.75 :
        (2.00 <= u && u < 3.00) ? 0.94 :
        (3.00 <= u && u < 6.25) ? 1.50 :
        (6.25 <= u && u < 7.00) ? 3.75 :
        (7.00 <= u && u < 8.00) ? 4.50 : 5.25;

    if (u >= 2) 
    mirrored(x) translate(-A/2*inch*x) stabil(); 
}

module plate_2D()
{
    translate(plate_size[1]*y)
    for (sw = switch_info) {
        pos = sw[0];
        rot = sw[1];
        unit = sw[2];
        row = sw[3];
        translate(pos) rotate(rot) plate_cutout(unit);
    }
}

