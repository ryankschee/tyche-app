var timeout = 1 * 30 * 1000; // minute * second * milliseconds 
var i = 0;

function timer() 
{
	i = i + 1;
    postMessage( i );
    setTimeout("timer()", timeout);
}

timer();