$(document).ready(function() {
  $('body').on('click', '.follow-btn', function(event) {
    event.preventDefault();
    var user_id = $(this).attr('user_id');
    $.ajax({
      url: '/relationships',
      type: 'POST',
      dataType: 'json',
      data: {id: user_id},
    })
      .done(function(response) {
        if (response.status == 'success') {
          $('.follow-act-form').html(response.btn_html);
          $('.followers').text(parseInt($('.followers').text()) + 1);
        }
      })
      .fail(function() {
        alert('fail');
      });
    return false;
  });

  $('body').on('click', '.unfollow-btn', function(event) {
    event.preventDefault();
    var relationship_id = $(this).attr('relationship_id');
    $.ajax({
      url: '/relationships/'+relationship_id,
      type: 'DELETE',
      dataType: 'json',
      data: {id: relationship_id},
    })
      .done(function(response) {
        if (response.status == 'success') {
          $('.follow-act-form').html(response.btn_html);
          $('.followers').text(parseInt($('.followers').text()) - 1);
        }
      })
      .fail(function() {
        alert('fail');
      });
    return false;
  });
});
