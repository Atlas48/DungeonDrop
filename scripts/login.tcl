# This is heavaly work in progress
# This is meant to extend eggdrop's login feature 
# This involves SQLite. A lot.
package require sqlite 

namespace eval login{

#Command used to lookup entries via message-
variable login::lookup "!lookup"
#Authorization for the command-
variable login::lookupauth ""

#Command used to edit entries-
variable login::set "!set"
#Authorization for the command-
variable login::setauth ""

#Command used to register entries-
variable login::register "!register"
#Authorization for the command-
variable login::registerauth ""

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
		Class varchar(255)
        Bio varchar(255)
        Catchprase varchar(255)
        STR int(255)
        DEX int(255)
        CON int(255)
        WIZ int(255)
        CHA int(255)
        )
        }
	bind join * * joinup
	bind msg login::re
       proc joinup {nick hand idx chan} {
          if {db1 exists {SELECT $nick FROM Adventurer} == true} {
			puthelp "PRVMSG $nick: Welcome back $nick"
			puthelp "PRVMSG $chan: $nick has joined!"
			chattr $nick +v $chan
          } 
		  else {
			puthelp "PRVMSG $chan : A new player has joined, $nick! Now play nice..."
			puthelp "PRVMSG $nick : Welcome $nick, I am $botnick, and welcome to $chan"
			puthelp "PRVMSG $nick : Type $login::register [YourNick] to register"
			puthelp "PRVMSG $nick : "
			}   
	}
	