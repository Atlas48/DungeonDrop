# This is heavaly work in progress
# this is meant to extend eggdrop's login feature 
package require sqlite

    if {[catch {source scripts/login.tcl>} err} {
            putlog "Error while loading login.tcl: $err"
    } else {
            putlog "login.tcl loaded without errors"
    }
	
	bind join 