$(document).ready ->

  # Open external links in a new window
  hostname = window.location.hostname
  $("a[href^=http]")
    .not("a[href*='" + hostname + "']")
    .addClass('link external')
    .attr('target', '_blank')

  $('.page.journal p.post-meta').prev()
    .append("<span class='marshally'>&nbsp;</span>")
    .append("<span class='pengwynn'>&nbsp;</span>")

  # syntax
  $('pre>code').addClass('prettyprint')
  prettyPrint()
