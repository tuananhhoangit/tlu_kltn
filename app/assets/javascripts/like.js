$(document).ready(function() {
  $('body').on('click', '.btn-like', function(event) {
    event.preventDefault();
    var post_id = $(this).closest('.post-item').attr('post_id');
    var btn_like = $(this);
    $.ajax({
      url: btn_like.closest('.new-like').attr('action'),
      type: 'POST',
      dataType: 'json',
      data: {post_id: post_id},
    })
      .done(function(response) {
        if (response.status == 'success') {
          btn_like.closest('.likes').html(response.likes_html);
        }
      })
      .fail(function() {
        alert('fail');
      });
    return false;
  });

  $('body').on('click', '.unlike-btn', function(event) {
    event.preventDefault();
    var post_id = $(this).closest('.post-item').attr('post_id');
    var unlike_btn = $(this);
    $.ajax({
      url: unlike_btn.attr('href'),
      type: 'DELETE',
      dataType: 'json',
      data: {post_id: post_id},
    })
      .done(function(response) {
        if (response.status == 'success') {
          unlike_btn.closest('.likes').html(response.likes_html);
        }
      })
      .fail(function() {
        alert('fail');
      });
    return false;
  });
});
