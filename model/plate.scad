include <common.scad>
use <top_cutout.scad>
/* use <base.scad> */

difference()
{
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
    square(0.55*inch, true);
    mirrored(x) mirrored(y)
    translate(0.1972/2*inch*y) square([0.6140/2, (0.55-0.1972)/2]*inch);
}

module plate_cutout(u) {
    if (u == 6)  translate(0.5*unit*x) switch();
    else         switch();

    A = (u == 6)                ? 3.75 :
        (u == 4.5)              ? 2.73 :
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

