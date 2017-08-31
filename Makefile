MODEL_DIR = model
OUT_DIR = out
VPATH = $(MODEL_DIR):$(OUT_DIR)

LAYOUT = layout/hhkb.layout
SCAD = openscad-nightly
STL_TARGET = preview
DXF_TARGET = top_cutout plate

STL_TARGET := $(foreach f,$(STL_TARGET),$(OUT_DIR)/$(f).stl)
DXF_TARGET := $(foreach f,$(DXF_TARGET),$(OUT_DIR)/$(f).dxf)
LAYOUT_TARGET = $(MODEL_DIR)/params.scad

.PHONY: all stl layout clean
all: $(LAYOUT_TARGET) $(STL_TARGET) $(DXF_TARGET)

stl: $(LAYOUT_TARGET) $(STL_TARGET)

dxf: $(LAYOUT_TARGET) $(DXF_TARGET)

$(LAYOUT_TARGET): $(LAYOUT)
		python3 layout_parser.py $(LAYOUT) > $@

$(OUT_DIR)/%.stl: %.scad 
		mkdir -p $(OUT_DIR)
		$(SCAD) -o $@ $<

$(OUT_DIR)/%.dxf: %.scad 
		mkdir -p $(OUT_DIR)
		$(SCAD) -o $@ $<

clean:
		rm $(MODEL_DIR)/params.scad
		rm $(OUT_DIR)/*

