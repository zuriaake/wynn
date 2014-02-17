$(document).ready(function() {

  // syntax
  $('pre>code').addClass('prettyprint');
  prettyPrint();

  // Open external links in a new window
  hostname = window.location.hostname
  $("a[href^=http]")
    .not("a[href*='" + hostname + "']")
    .addClass('link external')
    .attr('target', '_blank');


  // hide address bar
  setTimeout(function() { window.scrollTo(0, 1) }, 100);

});
