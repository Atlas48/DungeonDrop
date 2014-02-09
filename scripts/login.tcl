# This is heavaly work in progress
# This is meant to extend eggdrop's login feature 
# This involves SQLite. A lot.
package require sqlite 

namespace eval login{
#command used to lookup entries
variable login::lookup ""

}
   
   if {[catch {source scripts/login.tcl>} err} {
            putlog "Error while loading login.tcl: $err"
    } else {
            putlog "login.tcl loaded without errors"
    }
	
	sqlite db1 ~/sql/database
	
        sqlite db1 ~/sql/database1.sqlite
        db1 eval {CREATE TABLE IF NOT EXISTS db1.usersheet
        (
        ID int(255)
        Adventurer varchar(255)
        Race varchar(255)
        Bio varchar(255)
        Catchprase varchar(255)
        STR int(255)
        DEX int(255)
        CON int(255)
        WIZ int(255)
        CHA int(255)x
        )
        }
	bind join * * joinup
       procname joinup {nick hand idx chan} {
          if {db1 exists {SELECT $nick FROM Adventurer} == true} {
	  puthelp "PRVMSG: Welcome back $nick"
	  puthelp "$nick has joined!"
	  chattr $nick +v chan
          } else {
	 
	 }   
	

