$(document).ready(function() {
  $('.save').hide();
  $('body').on('click', '.edit-post', function(event){
    event.preventDefault();
    var post_id = $(this).attr('post_id');
    var title = $(this).closest('.post-item').find('h3').text();
    var content = $(this).closest('.post-item').find('p').text();
    $(this).closest('.main').prev().find('span').text('Edit post');
    $('.title').val(title);
    $('.content').val(content);
    $('.save').attr('post_id', post_id);
    $('.post').hide();
    $('.save').show();
  });

  $('body').on('click', '.save', function(event){
    event.preventDefault();
    var new_title = $('.title').val();
    var new_content = $('.content').val();
    var post_id = $(this).attr('post_id');
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
          $('.title').val('');
          $('.content').val('');
          $('.save').hide();
          $('.post').show();
        }
      })
      .fail(function() {
        alert('fail');
      });
    return false;
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
