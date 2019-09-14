var timeout = 1 * 1 * 1000; // minute * second * milliseconds 
var i = 0;

function timedCount() {
    i = i + 1;
    postMessage(i);
    setTimeout("timedCount()", timeout);
}

timedCount();