$(function () {
  var converter = new showdown.Converter();

  $('.markdown-source').bind('input propertychange', function() {
      var text = $('.markdown-source').val();
      var html = '<hr><strong>Preview:</strong><br/>'+ converter.makeHtml(text) + '<hr>';
      $('#markdown-preview').html(html);
  });
});
