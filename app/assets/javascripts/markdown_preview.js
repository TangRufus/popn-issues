$(function () {

    if (! $('[data-markdown="source"]'))
      return;

      if (! $('[data-markdown="preview"]'))
        return;

  var md = window.markdownit({
    html: true,
    breaks: true,
    linkify: true,
  });

  $('[data-markdown="source"]').bind('input propertychange', function() {
    $result = md.renderInline($(this).val());
    $html = '<hr><strong>Preview:</strong> <a class="text-muted" href="http://www.emoji-cheat-sheet.com/" target="_blank"><small>opss.. something wrong Emoji previewing...</small></a><br/><br/>'+ $result + '<hr>';
    $('[data-markdown="preview"]').html($html);
  });
});
