include <common.scad>
use <top_cutout.scad>
/* use <base.scad> */

difference()
{
    translate(-layout_pos)
    top_cutout_2D();
    plate_2D();
}

module ear(hole_x, hole_y, drill_d) {
    $fn=17;
    translate([hole_x, hole_y]/2-[1, 1]*drill_d/2)
    hull() {
        circle(d=drill_d);
        translate([1, 1]*drill_d/2) circle(d=drill_d);
    }
}

module stabil() {
    e = 0.1;
    translate([0, -0.03]*inch) {
        square([0.13, 0.55]*inch + [e, e], true);
        mirrored(x) mirrored(y) ear(0.13*inch+e, 0.55*inch+e, 1+e);
    }
}
module switch() {
    e = 0.1;
    hole_x = 15.5 + e;
    hole_y = 12.8 + e; 
    drill_d = 1.0 + e;
    square([hole_x, hole_y], true);
    mirrored(x) mirrored(y) ear(hole_x, hole_y, drill_d);
//    mirrored(x) translate((hole_x-drill_d)/2*x) square([drill_d, hole_y+drill_d], true);
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

