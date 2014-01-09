#Type:    
#This script allows channel operators to add annotations to the Eggdrop logfile via the party line.
#Perfect if you want to make some changes.
    if {[catch {source scripts/note.tcl>} err} {
            putlog "Error while loading note.tcl: $err"
    } else {
            putlog "note.tcl loaded without errors"
    }
	
	set call *
    bind dcc +0 note$call dcc:note
    procname dcc:note{ hand idx text ){
    putlog "$call"
    }

