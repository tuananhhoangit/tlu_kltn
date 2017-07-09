$(document).ready(function(){
  $('.display-comment').hide();
  $('body').on('click', '.show-cmt', function(){
    $(this).closest('.post-item').find('.display-comment').show();
  });

  $('body').on('submit', '.new-comment', function(event){
    event.preventDefault();
    var self = $(this);
    var post_id = self.closest('.post-item').attr('post_id');
    var params = self.serialize();
    $.ajax({
      url: self.attr('action'),
      type: 'POST',
      dataType: 'json',
      data: params,
    })
      .done(function(response) {
        if (response.status == 'success') {
          self.closest('.post-'+post_id).find('.display-comment').append(response.html);
          self.find('.cmt-box').val('');
          $('.edit-comment').hide();
        }
      });
    return false;
  });

  $('.edit-comment').hide();
  $('body').on('click', '.edit-btn', function(event) {
    event.preventDefault();
    var self = $(this);
    self.closest('.info').hide();
    $('.edit-comment').hide();
    self.closest('.info').prev().show();
  });

  $('body').on('submit', '.edit-comment', function(event) {
    event.preventDefault();
    var self = $(this);
    var new_cmt = self.find('.cmt-edit-box').val();
    var url_patch = self.next().find('.delete').attr('href');
    var params = self.serialize();
    $.ajax({
      url: url_patch,
      type: 'PATCH',
      dataType: 'json',
      data: params,
    })
      .done(function(response) {
        if (response.status == 'success') {
          self.next().find('.content').text(new_cmt);
          self.hide();
          self.next().show();
        }
      });
    return false;
  });

  $('body').on('click','.delete', function(event) {
    event.preventDefault();
    var self = $(this);
    var r = confirm('You sure');
    if(r == true) {
      $.ajax({
        type: 'DELETE',
        url: self.attr('href'),
        dataType: 'json'
      })
        .done(function (response) {
          if (response.status == 'success') {
            self.closest('.comment-item').fadeOut('normal');
          }
        });
    }
    return false;
  });
});
