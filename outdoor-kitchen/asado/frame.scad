include <./config.scad>

module frame() {


    module partsList() {
        echo(str("Beschreibung;Stück;Länge;Breite;Höhe"));


        // Träger
        echo(str("Träger - Gehrung beidseitig", ";", "1", ";", outerWidth - fireBasketWidth - (profileSize * 2), ";", profileSize, ";", profileSize));
        // Stützen
        echo(str("Stützen - Gehrung einseitig / 22mm Bohrung für Spindel", ";", "2", ";", outerHight, ";", profileSize, ";", profileSize));

        // Stützen
        echo(str("Füsse Rechts - Stumpf", ";", "2", ";", fireBasketGroundClearance, ";", profileSize, ";", profileSize));

        // Rahmen rechts
        echo(str("Rahmen rechts - Gehrung einseitig", ";", "1", ";", outerDepth, ";", profileSize, ";", profileSize));

        // Rahmen hinten
        echo(str("Rahmen hinten - Gehrung einseitig", ";", "1", ";", outerWidth - fireBasketWidth - profileSize, ";", profileSize, ";", profileSize));



    }





    // Rahmen
    // Fuss rechts Hinten
    cube(size = [profileSize, profileSize, fireBasketGroundClearance]);

    // Fuss rechts Vorne
    translate([0, outerDepth - profileSize, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance]);

    // Fuss links Hinten
    translate([outerWidth - profileSize, 0, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance + profileSize + fireBasketHeight]);

    // Fuss links Vorne
    translate([outerWidth - profileSize, outerDepth - profileSize, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance + profileSize + fireBasketHeight]);

    // Fuss mitte Hinten
    translate([outerWidth - profileSize - fireBasketWidth, 0, fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, profileSize + fireBasketHeight]);

    // Fuss mitte Vorne
    translate([outerWidth - profileSize - fireBasketWidth, outerDepth - profileSize, fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, profileSize + fireBasketHeight]);


    // Profil Hinten
    translate([0, 0, fireBasketGroundClearance])
    cube(size = [outerWidth, profileSize, profileSize]);

    // Profil Rechts
    translate([0, 0, fireBasketGroundClearance])
    #cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Mitte
    translate([outerWidth - profileSize - fireBasketWidth, 0, fireBasketGroundClearance])
    cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Mitte Oben
    translate([outerWidth - profileSize - fireBasketWidth, 0, fireBasketGroundClearance + profileSize + fireBasketHeight])
    cube(size = [profileSize, outerDepth, profileSize]);


    // Profil Links
    translate([outerWidth - profileSize, 0, fireBasketGroundClearance])
    cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Links Oben
    translate([outerWidth - profileSize, 0, fireBasketGroundClearance + profileSize + fireBasketHeight])
    cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Vorne
    translate([outerWidth - fireBasketWidth, outerDepth - profileSize, fireBasketGroundClearance])
    cube(size = [fireBasketWidth, profileSize, profileSize]);

    // Profil Steg Mitte
    translate([outerWidth - fireBasketWidth, (outerDepth/2) - (profileSize/2), fireBasketGroundClearance])
    cube(size = [fireBasketWidth, profileSize, profileSize]);





    // Träger
    translate([profileSize, (outerDepth/2) - (profileSize/2), outerHight - profileSize])
    cube(size = [outerWidth - fireBasketWidth - (profileSize * 2), profileSize, profileSize]);

    // Stütze Rechts
    translate([profileSize, (outerDepth/2) - (profileSize/2), 0])
    cube(size = [profileSize, profileSize, outerHight]);

    // Stütze Links
    translate([outerWidth - fireBasketWidth - (profileSize * 2), (outerDepth/2) - (profileSize/2), 0])
    cube(size = [profileSize, profileSize, outerHight]);


    partsList();
}