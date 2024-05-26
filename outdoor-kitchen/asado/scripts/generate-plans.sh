#!/bin/bash

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


### FireProtection
# 3D Ansicht

echo "Generate FireProtection 3D View"
flatpak run org.openscad.OpenSCAD  --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,50,0,30,0 -o ../plans/fireProtection/fireProtection.png ../_view-fireProtection.scad

echo ""
echo "Generate FireBasket Parts List"
# Stückliste
flatpak run org.openscad.OpenSCAD  --export-format echo --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,40,0,200,0 -o ../plans/fireProtection/fireProtection-parts.csv ../_view-fireProtection.scad
sed -i 's/ECHO: "//g' ../plans/fireProtection/fireProtection-parts.csv
sed -i 's/"//g' ../plans/fireProtection/fireProtection-parts.csv
flatpak run org.libreoffice.LibreOffice --headless --infilter=text --convert-to pdf --outdir ../plans/fireProtection ../plans/fireProtection/fireProtection-parts.csv

# echo ""
# echo "Generate FireBasket Front Plan"
# # Vorderansicht
# flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/fireProtection/fireProtection-front.svg ../_projection-fireProtection-front.scad

# echo ""
# echo "Generate FireBasket Side Plan"
# # Vorderansicht
# flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/fireProtection/fireProtection-side.svg ../_projection-fireProtection-side.scad

# Draufsicht
echo ""
echo "Generate FireBasket Top Plan"
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/fireProtection/fireProtection-top.svg ../_projection-fireProtection-top.scad






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


### Collecting tray
# 3D Ansicht

echo "Generate CollectingTray 3D View"
flatpak run org.openscad.OpenSCAD  --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,70,0,210,0 -o ../plans/collectingTray/collectingTray.png ../_view-collectingTray.scad

echo ""
echo "Generate CollectingTray Parts List"
# Stückliste
flatpak run org.openscad.OpenSCAD  --export-format echo --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,40,0,200,0 -o ../plans/collectingTray/collectingTray-parts.csv ../_view-collectingTray.scad
sed -i 's/ECHO: "//g' ../plans/collectingTray/collectingTray-parts.csv
sed -i 's/"//g' ../plans/collectingTray/collectingTray-parts.csv
flatpak run org.libreoffice.LibreOffice --headless --infilter=text --convert-to pdf --outdir ../plans/collectingTray ../plans/collectingTray/collectingTray-parts.csv


echo ""
echo "Generate CollectingTray Front Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/collectingTray/collectingTray-front.svg ../_projection-collectingTray-front.scad


echo ""
echo "Generate CollectingTray Side Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/collectingTray/collectingTray-side.svg ../_projection-collectingTray-side.scad

# Draufsicht
echo ""
echo "Generate CollectingTray Top Plan"
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/collectingTray/collectingTray-top.svg ../_projection-collectingTray-top.scad




### Collecting tray mount
# 3D Ansicht

echo "Generate CollectingTray Mount 3D View"
flatpak run org.openscad.OpenSCAD  --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,70,0,240,0 -o ../plans/collectingTrayMount/collectingTrayMount.png ../_view-collectingTrayMount.scad

echo ""
echo "Generate CollectingTray Mount Parts List"
# Stückliste
flatpak run org.openscad.OpenSCAD  --export-format echo --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,40,0,200,0 -o ../plans/collectingTrayMount/collectingTrayMount-parts.csv ../_view-collectingTrayMount.scad
sed -i 's/ECHO: "//g' ../plans/collectingTrayMount/collectingTrayMount-parts.csv
sed -i 's/"//g' ../plans/collectingTrayMount/collectingTrayMount-parts.csv
flatpak run org.libreoffice.LibreOffice --headless --infilter=text --convert-to pdf --outdir ../plans/collectingTrayMount ../plans/collectingTrayMount/collectingTrayMount-parts.csv


echo ""
echo "Generate CollectingTray Mount Front Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/collectingTrayMount/collectingTrayMount-front.svg ../_projection-collectingTrayMount-front.scad


echo ""
echo "Generate CollectingTray Mount Side Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/collectingTrayMount/collectingTrayMount-side.svg ../_projection-collectingTrayMount-side.scad

# Draufsicht
echo ""
echo "Generate CollectingTray Mount Top Plan"
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/collectingTrayMount/collectingTrayMount-top.svg ../_projection-collectingTrayMount-top.scad



### Grate
# 3D Ansicht

echo "Generate Grate 3D View"
flatpak run org.openscad.OpenSCAD  --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,70,0,190,0 -o ../plans/grate/grate.png ../_view-grate.scad

echo ""
echo "Generate Grate Parts List"
# Stückliste
flatpak run org.openscad.OpenSCAD  --export-format echo --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,40,0,200,0 -o ../plans/grate/grate-parts.csv ../_view-grate.scad
sed -i 's/ECHO: "//g' ../plans/grate/grate-parts.csv
sed -i 's/"//g' ../plans/grate/grate-parts.csv
flatpak run org.libreoffice.LibreOffice --headless --infilter=text --convert-to pdf --outdir ../plans/grate ../plans/grate/grate-parts.csv



echo ""
echo "Generate Grate Front Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/grate/grate-front.svg ../_projection-grate-front.scad

echo ""
echo "Generate Grate Side Plan"
# Vorderansicht
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/grate/grate-side.svg ../_projection-grate-side.scad

# Draufsicht
echo ""
echo "Generate Grate Top Plan"
flatpak run org.openscad.OpenSCAD --projection=ortho --imgsize 1920,1080 --viewall --autocenter --camera=0,0,0,0,0,0,0 -o ../plans/grate/grate-top.svg ../_projection-grate-top.scad
