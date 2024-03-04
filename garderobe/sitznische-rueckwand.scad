include <../library/modules.scad>


module regal(width, length, height, logThickness) {
    // überstand seitlich
    overhang = 250;
    // Höhenunterschied Dach
    heightDiff = 450;
    // Abstand von Unten bis zur untersten Querstrebe
    supportLowerSpace = 100;
    // Abstand von Oben/Vorne bis zur obersten Querstrebe
    supportUpperSpace = 250;
    // Höhe der Kajaks
    kajakHeight=380;


    // breite minus überstand seitlich geteilt durch zwei, wird Intern benötigt um die Pfosten zu positionieren
    moveLeg = (width - (2 * overhang) - logThickness) / 2;
    // Tablar Abstand
    shellIncrement = kajakHeight + logThickness;

    // pfosten hinten
    // links
    translate([-moveLeg, 0, 0])
        cube(size = [logThickness, logThickness, height], center = true);
    // rechts
    translate([moveLeg, 0, 0])
        cube(size = [logThickness, logThickness, height], center = true);

    // pfosten vorne
    // links
    translate([-moveLeg, -length, - heightDiff / 2])
        cube(size = [logThickness, logThickness, height - heightDiff], center = true);
    // rechts
    translate([moveLeg, -length, - heightDiff / 2])
        cube(size = [logThickness, logThickness, height - heightDiff], center = true);


    // querstreben
    // links unten
    translate([moveLeg, -length / 2, 0])
        translate([0, 0, - (height / 2) + (logThickness / 2) + supportLowerSpace])
            cube(size = [logThickness, length, logThickness], center = true);



    // links oben
    translate([moveLeg, -length / 2, 0])
        // oben
        translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace])
            cube(size = [logThickness, length, logThickness], center = true);
    
    // links erstes Tablar
    translate([moveLeg, -length / 2, 0])
        // oben
        translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - shellIncrement])
            cube(size = [logThickness, length, logThickness], center = true);

    // links zweites Tablar
    translate([moveLeg, -length / 2, 0])
        // oben
        translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - (shellIncrement * 2)])
            cube(size = [logThickness, length, logThickness], center = true);







    // rechts unten
    translate([-moveLeg, -length / 2, 0])
        translate([0, 0, - (height / 2) + (logThickness / 2) + supportLowerSpace])
            cube(size = [logThickness, length, logThickness], center = true);
        
    // rechts oben
    translate([-moveLeg, -length / 2, 0])
        // oben
        translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace])
            cube(size = [logThickness, length, logThickness], center = true);

    // rechts erstes Tablar
    translate([-moveLeg, -length / 2, 0])
        // oben
        translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - shellIncrement])
            cube(size = [logThickness, length, logThickness], center = true);

    // rechts zweites Tablar
    translate([-moveLeg, -length / 2, 0])
        // oben
        translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - (shellIncrement * 2)])
            cube(size = [logThickness, length, logThickness], center = true);



    // streben längs
    // hinten oben 
    translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace])
        cube(size = [width - (overhang * 2), logThickness, logThickness], center = true);

    // hinten erstes Tablar
    translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - shellIncrement])
        cube(size = [width - (overhang * 2), logThickness, logThickness], center = true);

    // hinten zweites Tablar
    translate([0, 0, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - (shellIncrement * 2)])
        cube(size = [width - (overhang * 2), logThickness, logThickness], center = true);


    // vorne oben 
    translate([0, - length, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace])
        cube(size = [width - (overhang * 2), logThickness, logThickness], center = true);

    // vorne erstes Tablar
    translate([0, - length, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - shellIncrement])
        cube(size = [width - (overhang * 2), logThickness, logThickness], center = true);

    // vorne zweites Tablar
    translate([0, - length, (height / 2 - logThickness / 2) - heightDiff - supportUpperSpace - (shellIncrement * 2)])
        cube(size = [width - (overhang * 2), logThickness, logThickness], center = true);


    module partsList() {
        // Beine Hinten
        echo(str("Beine Hinten", ";", "2", ";", height, ";", logThickness, ";", logThickness));
        echo(str("Beine Vorne", ";", "2", ";", height - heightDiff, ";", logThickness, ";", logThickness));
        echo(str("Quer-Streben", ";", "8", ";", length, ";", logThickness, ";", logThickness));
        echo(str("Längs-Streben", ";", "6", ";", width - (overhang * 2), ";", logThickness, ";", logThickness));
    }

    partsList();



}


regal(2500, 640, 2950, 80);
