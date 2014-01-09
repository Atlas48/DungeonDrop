
# You should include a file help.txt in the directory listed below
# Set the full pathname for the directory holding the files to share
# It must begin and end in /
set fshome "~/fs/"

# List the subdirectories that this bot is allowed access to
# Enclose each in quotes, and separate them by a space
set fsdirs [list "humour" "mirc"]

bind msg - fs fs

proc fs { nick host handle text } {
  global botnick
  puthelp "PRIVMSG $nick :You can access my files with two commands:"
  puthelp "PRIVMSG $nick :  /msg $botnick fsfind <pattern>"
  puthelp "PRIVMSG $nick :  /msg $botnick fsget <filename>"
  puthelp "PRIVMSG $nick :For more information about this, type:  /msg $botnick fsget help.txt"
  puthelp "PRIVMSG $nick :  and read the file sent to you"
}

proc fsgetsimplefilename { fullname } {
  return [lindex [split $fullname [list "/"]] end]
}

proc fsisokdir { text } {
  global fsdirs
  if {$text == ""} { return 1 }
  if {[string first "/" $text] == -1} { return 1 }
  set text [lindex [split $text [list "/"]] 0]
  if {[lsearch $fsdirs $text] == -1} { return 0 }
  return 1
}

bind msg - fsfind fsfind

proc fsfind { nick host handle text } {
  global fshome fsdirs
  if {$text == ""} { set text "*" } else {set text [lindex $text 0]}
  if {[string first ".." $text] != -1} {
    puthelp "PRIVMSG $nick :Unauthorized path name"
    return 0
  }
  if {[fsisokdir $text] == 0} {
    puthelp "PRIVMSG $nick :Access denied.  This bot can access only:  $fsdirs"
    return 0
  }
  set f [lsort [glob -nocomplain "$fshome$text"]]
  puthelp "PRIVMSG $nick :Matches found for $text:"
  set fsfound 0
  foreach x $f {
    if {[file isdirectory $x] == 1} {set y "   <DIR>"} else {
      set y "   [file size $x] bytes"
    }
    puthelp "PRIVMSG $nick :[fsgetsimplefilename $x]$y"
    incr fsfound
  }
  puthelp "PRIVMSG $nick :Matches found:  $fsfound"
}

bind msg - fsget fsget

proc fsget { nick host handle text } {
  global fshome fsdirs
  if {$text == ""} {
    puthelp "PRIVMSG $nick :You need to specify a filename also"
    return 0
  }
  set text [lindex $text 0]
  if {[string first ".." $text] != -1} {
    puthelp "PRIVMSG $nick :Unauthorized path name"
    return 0
  }
  if {[fsisokdir $text] == 0} {
    puthelp "PRIVMSG $nick :Access denied.  This bot can access only:  $fsdirs"
    return 0
  }
  if {[file exists "$fshome$text"] == 0} {
    puthelp "PRIVMSG $nick :No such file"
    return 0
  }
  if {[file isfile "$fshome$text"] == 0} {
    puthelp "PRIVMSG $nick :$text is a directory, not a file"
    return 0
  }
  dccsend "$fshome$text" $nick
}

putlog "\002(5: \0033TFS\003)\002 Loaded: \002fs.tcl v1.1\002 by terri, April 2001"
putlog "\002(5: \0033TFS\003)\002 A BotService Production -- \002http://www.botservice.net\002"

