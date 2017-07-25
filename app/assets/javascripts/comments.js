$(document).ready(function(){
  $('.display-comment').hide();
  $('body').on('click', '.show-cmt', function(){
    $(this).closest('.post-item').find('.display-comment').show();
  });

  $('body').on('submit', '.new-comment', function(event){
    event.preventDefault();
    var form_comment = $(this);
    var post_id = $(this).closest('.post-item').attr('post_id');
    var params = $(this).serialize();
    $.ajax({
      url: form_comment.attr('action'),
      type: 'POST',
      dataType: 'json',
      data: params,
    })
      .done(function(response) {
        if (response.status == 'success') {
          form_comment.closest('.post-'+post_id).find('.display-comment').append(response.html);
          form_comment.find('.cmt-box').val('');
          $('.edit-comment').hide();
        }
      });
    return false;
  });

  $('.edit-comment').hide();
  $('body').on('click', '.edit-btn', function(event) {
    event.preventDefault();
    $(this).closest('.info').hide();
    $('.edit-comment').hide();
    $(this).closest('.info').prev().show();
  });

  $('body').on('submit', '.edit-comment', function(event) {
    event.preventDefault();
    var edit_cmt_form = $(this);
    var new_cmt = $(this).find('.cmt-edit-box').val();
    var url_patch = $(this).next().find('.delete').attr('href');
    var params = $(this).serialize();
    $.ajax({
      url: url_patch,
      type: 'PATCH',
      dataType: 'json',
      data: params,
    })
      .done(function(response) {
        if (response.status == 'success') {
          edit-cmt-form.next().find('.content').text(new_cmt);
          edit-cmt-form.hide();
          edit-cmt-form.next().show();
        }
      });
    return false;
  });

  $('body').on('click','.delete', function(event) {
    event.preventDefault();
    var delete_btn = $(this);
    var r = confirm('You sure');
    if(r == true) {
      $.ajax({
        type: 'DELETE',
        url: delete_btn.attr('href'),
        dataType: 'json'
      })
        .done(function (response) {
          if (response.status == 'success') {
            delete_btn.closest('.comment-item').fadeOut('normal');
          }
        });
    }
    return false;
  });
});
