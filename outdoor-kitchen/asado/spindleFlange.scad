include <./config.scad>

module spindleFlange() {

    module partsList() {
        // Spindelplatte
        echo(str("40;Flanschen - ;2;", spindleDiameter*3, ";", spindleDiameter, ";", spindleDiameter));
    }

    partsList();
}
