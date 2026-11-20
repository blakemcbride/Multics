// how to call calendar() with a URL from a form.
// USAGE: include this file in the HEAD of your document.
// then insert a BODY tag that says <BODY onload="show_calendar(window.location.search, 'calcontent')">
//
// Copyright (c) Tom Van Vleck, 2016
//
function show_calendar(window_search_string, id_tag_to_replace_contents) {
    var file = "calinput.calin";  // relative path name of input text file
    if ((typeof(window_search_string) != 'undefined') && (window_search_string != "")) {
	file = window_search_string.substring(1); // remove the question mark
    }
    var out = calendar(file);	// compute a calendar.
    var xo = document.getElementById(id_tag_to_replace_contents);
    if (typeof xo == 'undefined') {
        return;			// do nothing if can't find where to put it
    }
    xo.innerHTML = out;		// replace the element's contents with the calendar
} // show_calendar
