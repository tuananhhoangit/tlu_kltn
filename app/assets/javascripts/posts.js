$(document).ready(function() {
  $('body').on('click', '.edit-post', function(event){
    event.preventDefault();
    var self = $(this);
    var post_id = self.attr('post_id');
    var title = self.closest('.post-item').find('h3').text();
    var content = self.closest('.post-item').find('p').text();
    self.closest('.main').prev().find('span').text('Edit post');
    $('.title').val(title);
    $('.content').val(content);
    $('.post').attr({'post_id': post_id, 'action': 'edit'});
  });

  $('body').on('click', '.post', function(event){
    event.preventDefault();
    var self = $(this);
    var new_title = $('.title').val();
    var new_content = $('.content').val();
    var post_id = self.attr('post_id');
    if (self.attr('action') == 'edit') {
      $.ajax({
        url: '/posts/' + post_id,
        type: 'PUT',
        dataType: 'json',
        data: {id: post_id, title: new_title, content: new_content},
      })
        .done(function(response) {
          if (response.status == 'success') {
            $('#post-' + post_id).find('h3').text(new_title);
            $('#post-' + post_id).find('p').text(new_content);
            $('.title').val('');
            $('.content').val('');
          }
        })
        .fail(function() {
          alert('fail');
        });
      return false;
    } else {
      $.ajax({
        url: '/posts',
        type: 'POST',
        dataType: 'json',
        data: {id: post_id, title: new_title, content: new_content},
      })
        .done(function(response) {
          if (response.status == 'success') {
            $('.main').prepend(response.html);
            $('.title').val('');
            $('.content').val('');
          }
        })
        .fail(function() {
          alert('fail');
        });
      return false;
    }
  });

  $('body').on('click', '.delete-post', function(event){
    event.preventDefault();
    var self = $(this);
    var r = confirm(I18n.t('you_sure'));
    if(r == true) {
      $.ajax({
        type: 'DELETE',
        url: self.attr('href'),
        dataType: 'json'
      })
        .done(function (response) {
          if (response.status == 'success') {
            self.closest('li').slideUp(400);
          }
        })
        .fail(function() {
          alert('fail');
        });
    }
    return false;
  });
});
