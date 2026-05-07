$fn = 256;

tableExtended = true;
legsExtended = false;

tableTopWidth = 1000;
tableTopLength = 1790;

tableTopProfileWidth = 40;
tableTopProfileHeight = 20;
tableTopProfileGap = 30;
tableTopProfileThickness = 3;

tableFrameProfileWidth = 30;
tableFrameProfileHeight = 60;
tableFrameProfileThickness = 4;
tableFrameAirGap = 5;

tableSupportsWidth = 30;
tableSupportsThickness = 3;

tableFrameInnerProfileWidth = 20;
tableFrameInnerProfileHeight = 50;
tableFrameInnerProfileThickness = 3;

tableFrameExtensionLength = 950;

tableLegsOverlap = 100;
tableLegsBaseWidth = 80;
tableLegsBaseThickness = 4;

wallMountlength = tableTopWidth + tableFrameProfileWidth * 2+ tableFrameAirGap * 2 + tableLegsBaseThickness + tableFrameProfileWidth + tableFrameAirGap;
wallMountWidth = 80;
wallMountThickness = 4;


module tube(outerWidth = 40, outerHeight = 20, thickness = 3, length = 1500) {
    difference() {
        cube([length, outerWidth, outerHeight]);
        
        translate([-5, thickness, thickness])
        cube([length + 10, outerWidth - thickness * 2, outerHeight - thickness * 2]);
    }
}

module angle(outerWidth = 30, outerHeight = 30, thickness = 3, length = 1500) {
    difference() {
        cube([length, outerWidth, outerHeight]);
        
        translate([-5, thickness, thickness])
        cube([length + 10, outerWidth, outerHeight]);
    }
}

module uProfile(outerWidth = 30, outerHeight = 30, thickness = 3, length = 1500) {
    difference() {
        cube([length, outerWidth, outerHeight]);
        
        translate([-5, thickness, -thickness])
        cube([length + 10, outerWidth - thickness * 2, outerHeight]);
    }
}

module tableTop() {
    // reference plate
    //cube ([1000, 1790, 10]);
    incrementWidth = tableTopProfileWidth + tableTopProfileGap;
    increments = (tableTopLength - tableTopProfileWidth) / incrementWidth;
    for (i=[0:increments]) {
       translate([0,i*incrementWidth,0])
         tube(
            outerWidth = tableTopProfileWidth,
            outerHeight = tableTopProfileHeight,
            thickness = tableTopProfileThickness,
            length = tableTopWidth
     
        );
    }


    // table fixations
    translate([tableSupportsWidth * 2 - tableFrameAirGap + 1, 0, 0])
    rotate([-90, 0, 90])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );

    translate([tableTopWidth - tableSupportsWidth * 2 + tableFrameAirGap - 1, 0, 0])
    rotate([180, 0, 90])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );
}

module topFrame() {
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2
    );

    translate([0, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth, 0])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2
    );



    // left
    translate([tableFrameProfileWidth, tableFrameProfileWidth, 0])
    rotate([0, 0, 90])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopWidth + tableFrameAirGap * 2
    );

    // right
    translate([tableFrameProfileWidth * 2 + tableTopLength + tableFrameAirGap * 2, tableFrameProfileWidth, 0])
    rotate([0, 0, 90])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopWidth + tableFrameAirGap * 2
    );



    // table supports
    translate([tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileWidth, tableFrameProfileHeight - tableTopProfileHeight])
    rotate([-90, 0, 0])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );

    translate([tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileWidth + tableFrameAirGap * 2 + tableTopWidth, tableFrameProfileHeight - tableTopProfileHeight])
    rotate([180, 0, 0])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );


    extensionValue = tableExtended ? 800 : 0;

    translate([-extensionValue, 0, 0]) {
        translate([-tableFrameProfileThickness, tableFrameProfileThickness, tableFrameProfileThickness])
        tube(
            outerWidth = tableFrameInnerProfileWidth,
            outerHeight = tableFrameInnerProfileHeight,
            thickness = tableFrameInnerProfileThickness,
            length = tableFrameExtensionLength
        );

        translate([-tableFrameProfileThickness, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth + tableFrameProfileThickness, tableFrameProfileThickness])
        tube(
            outerWidth = tableFrameInnerProfileWidth,
            outerHeight = tableFrameInnerProfileHeight,
            thickness = tableFrameInnerProfileThickness,
            length = tableFrameExtensionLength
        );


        translate([-tableFrameProfileThickness, tableFrameProfileWidth - tableFrameProfileWidth, 0])
        rotate([0, 0, 90])
        tube(
            outerWidth = tableFrameProfileWidth,
            outerHeight = tableFrameProfileHeight,
            thickness = tableFrameProfileThickness,
            length = tableTopWidth + tableFrameProfileWidth * 2+ tableFrameAirGap * 2
        );

    }

    // extension right
    translate([extensionValue, 0, 0]) {

        translate([tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2 - tableFrameExtensionLength + tableFrameProfileThickness, tableFrameProfileThickness, tableFrameProfileThickness])
        tube(
            outerWidth = tableFrameInnerProfileWidth,
            outerHeight = tableFrameInnerProfileHeight,
            thickness = tableFrameInnerProfileThickness,
            length = tableFrameExtensionLength
        );

        translate([tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2 - tableFrameExtensionLength + tableFrameProfileThickness, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth + tableFrameProfileThickness, tableFrameProfileThickness])
        tube(
            outerWidth = tableFrameInnerProfileWidth,
            outerHeight = tableFrameInnerProfileHeight,
            thickness = tableFrameInnerProfileThickness,
            length = tableFrameExtensionLength
        );

        translate([tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2 + tableFrameProfileThickness + tableFrameProfileWidth, tableFrameProfileWidth - tableFrameProfileWidth, 0])
        rotate([0, 0, 90])
        tube(
            outerWidth = tableFrameProfileWidth,
            outerHeight = tableFrameProfileHeight,
            thickness = tableFrameProfileThickness,
            length = tableTopWidth + tableFrameProfileWidth * 2+ tableFrameAirGap * 2
        );
    }
} 

module legs() {
    extensionValue = legsExtended ? 500 : 100;

    uProfile(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = 80
    );


    translate([0, tableFrameProfileThickness, tableFrameProfileThickness])
    tube(
        outerWidth = tableFrameInnerProfileWidth,
        outerHeight = tableFrameInnerProfileHeight,
        thickness = tableFrameInnerProfileThickness,
        length = 600
    );


    translate([extensionValue, 0, 0])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = 600
    );


    translate([0, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth, 0]) {
        uProfile(
            outerWidth = tableFrameProfileWidth,
            outerHeight = tableFrameProfileHeight,
            thickness = tableFrameProfileThickness,
            length = 80
        );

        translate([0, tableFrameProfileThickness, tableFrameProfileThickness])
        tube(
            outerWidth = tableFrameInnerProfileWidth,
            outerHeight = tableFrameInnerProfileHeight,
            thickness = tableFrameInnerProfileThickness,
            length = 600
        );

        translate([extensionValue, 0, 0])
        tube(
            outerWidth = tableFrameProfileWidth,
            outerHeight = tableFrameProfileHeight,
            thickness = tableFrameProfileThickness,
            length = 600
        );
    }

    translate([tableFrameProfileWidth + 400 + extensionValue, tableFrameProfileWidth, 0])
    rotate([0, 0, 90])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopWidth + tableFrameAirGap * 2
    );

    translate([extensionValue + 600, - (tableLegsBaseWidth - tableFrameProfileWidth) / 2, tableLegsBaseWidth - ((tableLegsBaseWidth - tableFrameProfileHeight) / 2)])
    rotate([0, 90, 0])
    cube([tableLegsBaseWidth, tableLegsBaseWidth, tableLegsBaseThickness]);

    translate([extensionValue + 600, tableTopWidth, tableLegsBaseWidth - ((tableLegsBaseWidth - tableFrameProfileHeight) / 2)])
    rotate([0, 90, 0])
    cube([tableLegsBaseWidth, tableLegsBaseWidth, tableLegsBaseThickness]);
}

module wallHolder() {
    cube([wallMountWidth, wallMountThickness, wallMountlength]);

    translate([-(250 - tableLegsBaseWidth/2), 70, 30])
    rotate([180, 0, 0])
    uProfile(outerWidth = 70, outerHeight = 30, thickness = 4, length = 500);

    translate([0, tableFrameProfileHeight + tableLegsBaseThickness, wallMountlength - tableFrameProfileWidth])
    rotate([90, 0, 0])
    tube(outerWidth = tableFrameProfileWidth, outerHeight = tableFrameProfileHeight, thickness = tableFrameProfileThickness, length = wallMountWidth);
}

module partsList()  {
    echo("Pos;Bezeichnung;Typ;Anzahl;Breite;Höhe;Dicke;Länge;Link Debrunner");
    echo(str("1;Platte;Vierkantrohr;25;", tableTopProfileWidth,";",tableTopProfileHeight,";",tableTopProfileThickness,";",tableTopWidth,";https://shop.d-a.ch/de/winkelstahl-s235jr-warmgewalzt-scharfkantig/p/M100384"));
    echo(str("2;Aufnahme und Verbinder Platte;Winkel;4;", tableSupportsWidth,";",tableSupportsWidth,";",tableSupportsThickness,";",tableTopLength,";https://shop.d-a.ch/de/winkelstahl-stahl-s235jr-kaltgerollt-gleichschenklig/p/M100407"));
    echo(str("3;Rahmen längs;Vierkantrohr;2;", tableFrameProfileWidth,";",tableFrameProfileHeight,";",tableFrameProfileThickness,";",tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("4;Rahmen quer;Vierkantrohr;2;", tableTopProfileWidth,";",tableTopProfileHeight,";",tableTopProfileThickness,";",tableTopWidth + tableFrameAirGap * 2,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("5;Auszug längs;Vierkantrohr;4;", tableFrameInnerProfileWidth,";",tableFrameInnerProfileHeight,";",tableFrameInnerProfileThickness,";",tableFrameExtensionLength,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("6;Auszug quer;Vierkantrohr;2;", tableFrameProfileWidth,";",tableFrameProfileHeight,";",tableFrameProfileThickness,";",tableTopWidth + tableFrameProfileWidth * 2+ tableFrameAirGap * 2,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("7;Aufnahme Beine;U-Profil;2;", tableFrameProfileWidth,";",tableFrameProfileHeight,";",tableFrameProfileThickness,";",80,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("8;Auszug Beine - innen;Vierkantrohr;4;", tableFrameInnerProfileWidth,";",tableFrameInnerProfileHeight,";",tableFrameInnerProfileThickness,";",600,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("9;Auszug Beine - aussen;Vierkantrohr;4;", tableFrameProfileWidth,";",tableFrameProfileHeight,";",tableFrameProfileThickness,";",600,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("10;Querverstrebung Beine;Vierkantrohr;2;", tableFrameProfileWidth,";",tableFrameProfileHeight,";",tableFrameProfileThickness,";",tableTopWidth + tableFrameAirGap * 2,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("11;Aufnahme Füsse;Flachstahl;4;", tableLegsBaseWidth,";",";",tableLegsBaseThickness,";",tableLegsBaseWidth,";https://shop.d-a.ch/de/flachstahl-stahl-s235jr-warmgewalzt/p/M100378"));
    echo(str("12;Wand Montage Basis;Flachstahl;1;", tableLegsBaseWidth,";",";",tableLegsBaseThickness,";",wallMountlength,";https://shop.d-a.ch/de/flachstahl-stahl-s235jr-warmgewalzt/p/M100378"));
    echo(str("13;Wand Montage unten;U-Profil;1;", 70,";",30,";",4,";", 500,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));
    echo(str("14;Wand Montage oben;Vierkantrohr;1;", tableFrameProfileWidth,";",tableFrameProfileHeight,";",tableFrameProfileThickness,";", wallMountWidth,";https://shop.d-a.ch/de/rechteckrohre-stahl-s235jr-kaltgewalzt-s1-rohschwarz/p/M100647"));

}

translate([tableTopLength + tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileHeight - tableTopProfileHeight])
rotate([0, 0, 90])
tableTop();

color("grey")
topFrame();

color("darkcyan")
translate([tableTopLength - tableLegsOverlap, 0, 0])
rotate([0, 90, 0])
legs();

color("darkcyan")
translate([tableLegsOverlap + tableFrameProfileHeight, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth * 2, 0])
rotate([180, 90, 0])
legs();

translate([0, -tableLegsBaseThickness, -200 + 60 + tableLegsBaseThickness])
rotate([-90, 0, 0])
translate([(tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2) / 2, -200, 0])
wallHolder();

partsList();