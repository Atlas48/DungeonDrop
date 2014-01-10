#
bind msg o say call

proc msg:call {
flush $shout
set $shout 
putquick $shout
}