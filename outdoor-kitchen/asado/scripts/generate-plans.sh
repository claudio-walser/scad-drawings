#!/bin/bash


# Usage: openscad [options] file.scad
# Allowed options:
#   --export-format arg          overrides format of exported scad file when
#                                using option '-o', arg can be any of its
#                                supported file extensions.  For ascii stl
#                                export, specify 'asciistl', and for binary stl
#                                export, specify 'binstl'.  Ascii export is the
#                                current stl default, but binary stl is planned
#                                as the future default so asciistl should be
#                                explicitly specified in scripts when needed.

#   -o [ --o ] arg               output specified file instead of running the
#                                GUI, the file extension specifies the type: stl,
#                                off, amf, 3mf, csg, dxf, svg, pdf, png, echo,
#                                ast, term, nef3, nefdbg (May be used multiple
#                                time for different exports). Use '-' for stdout

#   -D [ --D ] arg               var=val -pre-define variables
#   -p [ --p ] arg               customizer parameter file
#   -P [ --P ] arg               customizer parameter set
#   -h [ --help ]                print this help message and exit
#   -v [ --version ]             print the version
#   --info                       print information about the build process

#   --camera arg                 camera parameters when exporting png:
#                                =translate_x,y,z,rot_x,y,z,dist or
#                                =eye_x,y,z,center_x,y,z
#   --autocenter                 adjust camera to look at object's center
#   --viewall                    adjust camera to fit object
#   --imgsize arg                =width,height of exported png
#   --render arg                 for full geometry evaluation when exporting png
#   --preview arg                [=throwntogether] -for ThrownTogether preview
#                                png
#   --animate arg                export N animated frames
#   --view arg                   =view options: axes | crosshairs | edges |
#                                scales | wireframe
#   --projection arg             =(o)rtho or (p)erspective when exporting png
#   --csglimit arg               =n -stop rendering at n CSG elements when
#                                exporting png
#   --colorscheme arg            =colorscheme: *Cornfield | Metallic | Sunset |
#                                Starnight | BeforeDawn | Nature | DeepOcean |
#                                Solarized | Tomorrow | Tomorrow Night | Monotone

#   -d [ --d ] arg               deps_file -generate a dependency file for make
#   -m [ --m ] arg               make_cmd -runs make_cmd file if file is missing
#   -q [ --quiet ]               quiet mode (don't print anything *except*
#                                errors)
#   --hardwarnings               Stop on the first warning
#   --check-parameters arg       =true/false, configure the parameter check for
#                                user modules and functions
#   --check-parameter-ranges arg =true/false, configure the parameter range check
#                                for builtin modules
#   --debug arg                  special debug info
#   -s [ --s ] arg               stl_file deprecated, use -o
#   -x [ --x ] arg               dxf_file deprecated, use -o




### Frame

# 3D Ansicht
echo "Generate Frame 3D View"
flatpak run org.openscad.OpenSCAD  --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,80,0,200,0 -o ../plans/frame/frame.png ../_view-frame.scad

echo ""
echo "Generate Frame Parts List"
# Stückliste
flatpak run org.openscad.OpenSCAD  --export-format echo --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,40,0,200,0 -o ../plans/frame/frame-parts.csv ../_view-frame.scad
sed -i 's/ECHO: "//g' ../plans/frame/frame-parts.csv
sed -i 's/"//g' ../plans/frame/frame-parts.csv
flatpak run org.libreoffice.LibreOffice --headless --infilter=text --convert-to pdf --outdir ../plans/frame ../plans/frame/frame-parts.csv

echo ""
echo "Generate Frame Front Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/frame/frame-front.svg ../_projection-frame-front.scad

echo ""
echo "Generate Frame Side Plan"
# Seitenansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/frame/frame-side.svg ../_projection-frame-side.scad

# Draufsicht
echo ""
echo "Generate Frame Top Plan"
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/frame/frame-top.svg ../_projection-frame-top.scad


### Firebasket
# 3D Ansicht

echo "Generate FireBasket 3D View"
flatpak run org.openscad.OpenSCAD  --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,70,0,210,0 -o ../plans/fireBasket/fireBasket.png ../_view-fireBasket.scad

echo ""
echo "Generate FireBasket Parts List"
# Stückliste
flatpak run org.openscad.OpenSCAD  --export-format echo --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,40,0,200,0 -o ../plans/fireBasket/fireBasket-parts.csv ../_view-fireBasket.scad
sed -i 's/ECHO: "//g' ../plans/fireBasket/fireBasket-parts.csv
sed -i 's/"//g' ../plans/fireBasket/fireBasket-parts.csv
flatpak run org.libreoffice.LibreOffice --headless --infilter=text --convert-to pdf --outdir ../plans/fireBasket ../plans/fireBasket/fireBasket-parts.csv

echo ""
echo "Generate FireBasket Front Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/fireBasket/fireBasket-front.svg ../_projection-fireBasket-front.scad

echo ""
echo "Generate FireBasket Side Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/fireBasket/fireBasket-side.svg ../_projection-fireBasket-side.scad

# Draufsicht
echo ""
echo "Generate FireBasket Top Plan"
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/fireBasket/fireBasket-top.svg ../_projection-fireBasket-top.scad



### Grateframe
# 3D Ansicht

echo "Generate GrateFrame 3D View"
flatpak run org.openscad.OpenSCAD  --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,70,0,210,0 -o ../plans/grateFrame/grateFrame.png ../_view-grateFrame.scad


echo ""
echo "Generate GrateFrame Parts List"
# Stückliste
flatpak run org.openscad.OpenSCAD  --export-format echo --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,40,0,200,0 -o ../plans/grateFrame/grateFrame-parts.csv ../_view-grateFrame.scad
sed -i 's/ECHO: "//g' ../plans/grateFrame/grateFrame-parts.csv
sed -i 's/"//g' ../plans/grateFrame/grateFrame-parts.csv
flatpak run org.libreoffice.LibreOffice --headless --infilter=text --convert-to pdf --outdir ../plans/grateFrame ../plans/grateFrame/grateFrame-parts.csv

echo ""
echo "Generate GrateFrame Front Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/grateFrame/grateFrame-front.svg ../_projection-grateFrame-front.scad


echo ""
echo "Generate GrateFrame Side Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/grateFrame/grateFrame-side.svg ../_projection-grateFrame-side.scad

# Draufsicht
echo ""
echo "Generate GrateFrame Top Plan"
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/grateFrame/grateFrame-top.svg ../_projection-grateFrame-top.scad

