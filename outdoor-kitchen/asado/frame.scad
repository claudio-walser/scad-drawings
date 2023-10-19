include <./config.scad>

module frame() {


    module partsList() {

        // TODO: draw the parts as in the part list, its messy right now, the list ist correct

        // Träger
        echo(str("1;Träger - Gehrung beidseitig", ";", "1", ";", outerWidth - fireBasketWidth - (profileSize * 2), ";", profileSize, ";", profileSize));
        // Stützen
        echo(str("2;Stützen - Gehrung einseitig / 22mm Bohrung für Spindel", ";", "2", ";", outerHight, ";", profileSize, ";", profileSize));

        // Füsse
        echo(str("3;Fuss Rechts Hinten - Stumpf", ";", "1", ";", fireBasketGroundClearance, ";", profileSize, ";", profileSize));
        echo(str("4;Fuss Rechts Vorne - Gehrung einseitig", ";", "1", ";", fireBasketGroundClearance + profileSize, ";", profileSize, ";", profileSize));

        // Rahmen rechts
        echo(str("6;Rahmen rechts - Gehrung beidseit / Gehrung einmal 90° gedreht für Fuss", ";", "1", ";", outerDepth, ";", profileSize, ";", profileSize));

        // Rahmen hinten
        echo(str("7;Rahmen hinten - Gehrung einseitig", ";", "1", ";", outerWidth - fireBasketWidth - profileSize, ";", profileSize, ";", profileSize));

        // Korbhalter
        // Füsse lang
        echo(str("8;Füsse Links - Gehrung einseitig", ";", "2", ";", fireBasketGroundClearance + profileSize + profileSize + fireBasketHeight, ";", profileSize, ";", profileSize));
        // Füsse kurz
        echo(str("9;Füsse Mitte - Gehrung beidseitig", ";", "2", ";", profileSize + profileSize + fireBasketHeight, ";", profileSize, ";", profileSize));
        // Querstreben Gehrung
        echo(str("10;Querstreben lang - Gehrung beidseitig", ";", "3", ";", outerDepth, ";", profileSize, ";", profileSize));
        // Querstrebe Stumpf
        echo(str("11;Querstrebe kurz - Stump", ";", "1", ";", outerDepth - (profileSize * 2), ";", profileSize, ";", profileSize));
        // Stege
        echo(str("12;Stege kurz - Stump", ";", "3", ";", outerDepth - (profileSize * 2), ";", profileSize, ";", profileSize));

    }





    // Rahmen
    // Fuss rechts Hinten
    cube(size = [profileSize, profileSize, fireBasketGroundClearance]);

    // Fuss rechts Vorne
    translate([0, outerDepth - profileSize, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance]);

    // Fuss links Hinten
    translate([outerWidth - profileSize, 0, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance + profileSize + profileSize + fireBasketHeight]);

    // Fuss links Vorne
    translate([outerWidth - profileSize, outerDepth - profileSize, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance + profileSize + profileSize + fireBasketHeight]);

    // Fuss mitte Hinten
    translate([outerWidth - profileSize - fireBasketWidth, 0, fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, profileSize + profileSize + fireBasketHeight]);

    // Fuss mitte Vorne
    translate([outerWidth - profileSize - fireBasketWidth, outerDepth - profileSize, fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, profileSize + profileSize + fireBasketHeight]);


    // Profil Hinten
    translate([0, 0, fireBasketGroundClearance])
    cube(size = [outerWidth, profileSize, profileSize]);

    // Profil Rechts
    translate([0, 0, fireBasketGroundClearance])
    cube(size = [profileSize, outerDepth, profileSize]);

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