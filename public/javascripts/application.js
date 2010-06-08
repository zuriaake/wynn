// Put your application scripts here

jQuery(document).ready(function($) {
  
  $('.vimeo').each(function(index, element) {
    var videoId = $(element).attr('data-video-id');
    if (videoId) {
      if (Modernizr.video) {
        var src = 'http://www.vimeo.com/play_redirect?clip_id='+videoId+'&quality=mobile';
        var player = $('<video>')
          .attr('src', src)
          .attr('controls', 'controls')
          .attr('width', '550')
          .attr('height', '309');
        $(this).append(player);
      }
    }
  });
  
});