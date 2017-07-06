$(document).ready(function() {
  $('.display-comment').hide();
  $('.show-cmt').click(function() {
    $(this).closest('.tc-ch').find('.display-comment').show();
  });
});
