# Dice Roller
# This script is written from scratch but mirrors the functionality of the 
# "Dice Roll v1.0" script by leadZERO <leadzero@redportal.net>. 
# Notable differences are: support for negative modifiers works correctly,
# code is simplified and easier to read, and messages are less verbose.
#
# Author: Spacexplosion <spacexplosion@gmail.com>
# Version: 1.0
# Tested with Eggdrop 1.6.18
#
# Released under GNU Public License (GPL), I guess

namespace eval droll {
    # DEFINE TRIGGERS HERE
    variable pub_trig "!roll"
    variable msg_trig "roll"

    bind pub -|- $pub_trig droll::pub_roll
    bind msg -|- $msg_trig droll::msg_roll
}

# Process dice roll for public channel
# Returns 1 to comply with bind standard
proc droll::pub_roll {nick userhost hand chan text} {
    set msg [droll::roll $chan [concat $nick " rolls"] $text]
    putloglev p $chan [concat "diceroller: " $msg "($text)"]
    return 1
}

# Process dice roll for private message
# Returns 1 to comply with bind standard
proc droll::msg_roll {nick userhost hand text} {
    droll::roll $nick "You roll" $text
    return 1
}

# Parse command and sends response message
# Returns response string
proc droll::roll {recipient msgPrefix text} {
    set msg $msgPrefix

    if {[regexp {([0-9]+)d([0-9]+)([+-]?[0-9]*)} \
	        $text  match num sides mod]} {
	if {$num > 1000} {
	    append msg " too many dice" 
	} else {
	    append msg " [droll::diceCalc $num $sides $mod]"
	}
    } else {
	append msg { incorrectly. Try <n>d<x>[<mod>]: where \
                 <n> is number of dice, \
                 <x> is number of sides, \
                 <mod> is an expression of addition or subtraction}
    }

    putserv [concat "PRIVMSG " $recipient " :" $msg]
    return $msg
}

# Do the random generation and arithmetic
# Returns final total
proc droll::diceCalc {num sides mod} {
    set result 0
    for {set i 0} {$i < $num} {incr i} {
	set result [expr $result + [rand $sides]+1]
    }
    return [expr $result $mod]
}