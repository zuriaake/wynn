$(document).ready(function() {

  // syntax
  $('pre>code').addClass('prettyprint');
  prettyPrint();

  // lettering
  // $('h1 + p + p').lettering('words').children('span.word1').lettering();

  // Open external links in a new window
  hostname = window.location.hostname
  $("a[href^=http]")
    .not("a[href*='" + hostname + "']")
    .addClass('link external')
    .attr('target', '_blank');


  $('a.logo').hover(function() {
    $(this).children('img').attr('src', '/wynn/images/logo-back.png');
  }, function() {

    $(this).children('img').attr('src', '/wynn/images/logo.png');
  });

});
