$(document).ready(function() {
  $('.save').hide();
  $('body').on('click', '.edit-post', function(event){
    event.preventDefault();
    var post_id = $(this).attr('post_id');
    var title = $(this).closest('.post-item').find('h3').text();
    var content = $(this).closest('.post-item').find('p').text();
    html = $('#edit-post-form').html();
    $(this).closest('.action-btn').prev().children().hide();
    if ($(this).closest('.action-btn').prev().find('.edit-post-form').length) {
      $(this).closest('.action-btn').prev().find('.edit-post-form').show();
    } else { $(this).closest('.action-btn').prev().append(html); }
    $(this).closest('.action-btn').prev().find('.new-title').val(title);
    $(this).closest('.action-btn').prev().find('.new-content').val(content);
    $(this).closest('.action-btn').prev().find('.save-edit-post').attr('post_id', post_id);
    $(this).closest('.action-btn').hide();
  });

  $('body').on('click', '.save-edit-post', function(event){
    event.preventDefault();
    var new_title = $(this).closest('.edit-post-form').find('.new-title').val();
    var new_content = $(this).closest('.edit-post-form').find('.new-content').val();
    var post_id = $(this).attr('post_id');
    var save_post_btn = $(this);
    $.ajax({
      url: '/posts/' + post_id,
      type: 'PUT',
      dataType: 'json',
      data: {id: post_id, title: new_title, content: new_content},
    })
      .done(function(response) {
        if (response.status == 'success') {
          $('#post-' + post_id).find('h3 a').text(new_title);
          $('#post-' + post_id).find('p').text(new_content);
          save_post_btn.closest('.main-info').children().show();
          save_post_btn.closest('.main-info').find('.edit-post-form').hide();
          save_post_btn.closest('.main-info').next().show();
        }
      })
      .fail(function() {
        alert('fail');
      });
    return false;
  });

  $('body').on('click', '.cancel-edit-post', function(event){
    event.preventDefault();
    $(this).closest('.main-info').children().show();
    $(this).closest('.main-info').find('.edit-post-form').hide();
    $(this).closest('.main-info').next().show();
  });

  $('body').on('click', '.delete-post', function(event){
    event.preventDefault();
    var delete_post_btn = $(this);
    var r = confirm(I18n.t('you_sure'));
    if(r == true) {
      $.ajax({
        type: 'DELETE',
        url: delete_post_btn.attr('href'),
        dataType: 'json'
      })
        .done(function (response) {
          if (response.status == 'success') {
            delete_post_btn.closest('li').slideUp(400);
          }
        })
        .fail(function() {
          alert('fail');
        });
    }
    return false;
  });

  $('body').on('click', '.admin-delete-post', function(event){
    event.preventDefault();
    var admin_delete_btn = $(this);
    var r = confirm(I18n.t('you_sure'));
    if(r == true) {
      $.ajax({
        type: 'DELETE',
        url: admin_delete_btn.attr('href'),
        dataType: 'json'
      })
        .done(function (response) {
          if (response.status == 'success') {
            admin_delete_btn.closest('tr').slideUp(400);
          }
        })
        .fail(function() {
          alert('fail');
        });
    }
    return false;
  });
});
