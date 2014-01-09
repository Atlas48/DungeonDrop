# This is heavaly work in progress
# This is meant to extend eggdrop's login feature 
# This involves SQLite. A lot.
package require sqlite 
    if {[catch {source scripts/login.tcl>} err} {
            putlog "Error while loading login.tcl: $err"
    } else {
            putlog "login.tcl loaded without errors"
    }
	
	sqlite db1 ~/sql/database
	bind join * * joinup
	procname joinup {
	 db1 eval{ 
	 
	 }
	}
	