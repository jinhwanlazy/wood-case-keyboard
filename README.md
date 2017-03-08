# Brief
This is a hobby project, to make a copy of HHKB. 
I cannot say it can easily be reproducable, 
since different people have different tools and machines.
I will just leave the specific procedures for my setup.
Below is the hardwares and materials I used.

* [Shapeoko1](https://www.shapeoko.com/shapeoko1.html) with GRBL controller and limit switch at -X, +Y.
* [Master mechanic rotary tool](https://www.amazon.com/Jinding-Group-152294-Mechanic-100-Pieces/dp/B00AV95RWQ) .
* A 3D printer
* End mill with 6mm and 1mm of diameter.
* 330x130x34mm black walnut block.

# Case
## Build
Although the repository is shipped with final toolpaths but they can be 
generated by following steps.

### Requirements (for Ubuntu 16.04 LTS)
Install latest development version of OpenSCAD.

    wget -qO - http://files.openscad.org/OBS-Repository-Key.pub | sudo apt-key add -
    sudo apt-get install openscad-nightly

Install libraries
    
    cd ~/.local/share/OpenSCAD/libraries
    git clone https://github.com/openscad/scad-utils
    git clone https://github.com/openscad/list-comprehension-demos

Download the source

    cd ~/Documents
    git clone https://github.com/jinhwanlazy/diy_hhkb
    cd diy_hhkb

Install PyCam(https://github.com/SebKuzminsky/pycam).
It uses both version 0.6 and v0.5.1, Because v0.6 generally performs better,
but failed to produce proper toolpath in some cases.
Note that those two should be under the repository to make make command work.

    sudo apt-get install python-gtk2 python-opengl python-gtkglext1 python-rsvg python-pyode python-guppy
    wget https://github.com/SebKuzminsky/pycam/archive/v0.6.tar.gz
    tar xvzf v0.6.tar.gz
    wget https://github.com/SebKuzminsky/pycam/archive/v0.5.1.tar.gz
    tar xvzf v0.5.1.tar.gz

And following command will generate stl models and toolpathes.
    
    make

## Customization
### Parameters
`model` directory has CAD model of the case. 
It can be viewed and converted to STL format 3D model by [OpenSCAD](www.openscad.org/). 
Some parts of the case's shape are parameterized.
for example, Tilt angle and Overall height, and Roundness.
You can modifiy it in `model/shepe.sacd` file.

### Layout
The layout of the keyboard can be changed. 
`layout` directory contains files with
[keyboard-layout-editor](http://www.keyboard-layout-editor.com/)
compatible layout data. If you want build with your own layout, copy 
Raw data from http://www.keyboard-layout-editor.com/ and make a file with it.
You can feed one of the layout by following command.
Note that only a limited commands are supported.

    python3 layout_parser.py layout/hhkb.layout > model/params.scad

### Toolpath generation
Makefile has settings for each tasks. 
You have to manually modify the file to match your machine.
Or use any CAM software of your preference.

## Procedure to milling
These are the specific steps I had done. These are useless unless you have 
the exactly same machine and materials I have.

1. Shape left half
    - Fix the wood block with double-sided tape
    - Set 1mm end mill.
    - Place head to left top corner
    - Set the position as origin
    - Send $H
    - Note current coordinate (it was [-1.219, 33.376])
    - Remove all comments from `gcode/shape_left_finish.ngc`
    - Add these lines in `gcode/shape_left_rough.ngc` at line 7, and `gcode/shape_left_finish.ngc` at line 10.

            $H 
            G92 X-6.219 Y163.376 Z34

    - Change to 6mm end mill
    - Start milling with `gcode/shape_left_rough.ngc` followed by `gcode/shape_left_finish`
2. Shape right half
    - Take off the block
    - Re attach the block 8 cm left to the original position.
    - Change to 1mm end mill
    - place head to right top corner
    - Set position as origin
    - Send $H
    - Note current coordinate (it was [-100, 5])
    - Remove all comments from `gcode/shape_right_finish.ngc`
    - Add these lines in `gcode/shape_right_rough.ngc` at line 7, and `gcode/shape_right_finish.ngc` at line 10.

            $H 
            G92 X-5 Y135 Z34

    - Change to 6mm end mill
    - Start milling with `gcode/shape_left_rough.ngc` followed by `gcode/shape_left_finish`
    - Sand the block
3. Lip cutout
    - Print two `stl/clamp_front.stl` and one`stl/clamp_back.stl` with your 3D Printer
    - Take off the block
    - Fix the block at the center with the clamps.
    - Draw square to cut out at top. The size is specified in `model/params.scad`
    - Make sure that machine's build space covers the square
    - change to 1mm end mill
    - Place head to left top corner of the square
    - Set position as origin
    - Send $H
    - Note current coordinate (it was [-100, 5])
    - Add These lines in `gcode/top_cutout.ngc` at line 7

            $H
            G92 X...

    - Change to 6mm end mill
    - Start milling with `gcode/top_cutout.ngc`
    





# Requirements

# Machine
