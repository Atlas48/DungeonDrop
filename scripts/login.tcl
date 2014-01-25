# This is heavaly work in progress
# This is meant to extend eggdrop's login feature 
# This involves SQLite. A lot.
package require sqlite 
    if {[catch {source scripts/login.tcl>} err} {
            putlog "Error while loading login.tcl: $err"
    } else {
            putlog "login.tcl loaded without errors"
    }
	
<<<<<<< HEAD
	sqlite db1 ~/sql/database
	bind join * * joinup
	procname joinup {
	 db1 eval{ 
	 
	 }
	}
	
=======
        sqlite db1 ~/sql/database1.sqlite
        db1 eval{CREATE TABLE IF NOT EXISTS db1.usersheet
        (
        ID int(255)
        Adventurer varchar(255)
        Race varchar(255)
        bio varchar(255)
        catchprase varchar(255)
        STR int(255)
        DEX int(255)
        CON int(255)
        WIZ int(255)
        CHA int(255)
        )
        }
	bind join * * joinup
	procname joinup {
         
	 
	 }
	}
	
>>>>>>> 4cc7bf9145b28be16ecef6baeed27762a9c80d39
