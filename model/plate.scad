include <common.scad>
use <top_cutout.scad>
use <scad-utils/morphology.scad>
/* use <base.scad> */

difference()
{
    translate(-layout_pos)
    inset(d=0.25, $fn=17) top_cutout_2D();
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

module square_with_ear(size=[1, 1], center=false, drill_d=1.1)
{
    translate(size / 2 * (center ? 0 : 1))
    {
        square(size, true);
        mirrored(x) mirrored(y) ear(size[0], size[1], drill_d);
    }
}

module stabil(A=0.94) {
    e = 0.1;
    mirrored(x)
    {
        translate(-0.1*inch*y) square([A/2, 0.22]*inch);
        translate(A/2*inch*x)
        {
            translate([-0.262/2, -0.26]*inch)
            square_with_ear([0.262, 0.484]*inch);
            translate([-0.12/2, -0.306]*inch)
            square_with_ear([0.12, 0.3]*inch);
            translate([0, -0.02]*inch)
            square_with_ear([0.156, 0.11]*inch);

        }
    }
}

module switch() {
    e = 0.1;
    hole_x = 15.5 + e;
    hole_y = 12.8 + e; 
    drill_d = 1.0 + e;
    square_with_ear([15.5+e, 12.8+e], true, drill_d+e);
}

module plate_cutout(u) {
    switch();

    A = (u == 6)                ? 3 :
        (2.00 <= u && u < 3.00) ? 0.94 :
        (3.00 <= u && u < 6.25) ? 1.50 :
        (6.25 <= u && u < 7.00) ? 3.75 :
        (7.00 <= u && u < 8.00) ? 4.50 : 5.25;

    if (u >= 2) stabil(A);
}

module mounting_holes() {
    for (pos = mounting_hole_pos) {
        translate(pos) circle(d=5.8, $fn=36);
    }
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
    mounting_holes();
    echo(mounting_hole_pos);
}

