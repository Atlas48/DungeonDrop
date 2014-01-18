#
namespace eval shout {

}

bind msg +o say msg:call

proc msg:call {
flush $shout
set $shout 
putquick $shout
}