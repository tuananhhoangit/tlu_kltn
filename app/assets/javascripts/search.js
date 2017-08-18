$(document).ready(function() {
  $('.search').hide();
  $('body').on('click', '.select-search-users', function(event) {
    event.preventDefault();
    $('.search').show();
    $('.search-form').attr('action', 'users');
    $('.input-search').attr('placeholder', I18n.t('search_users'));
    $('.input-search').focus();
    $('.select-search-users').hide();
    $('.select-search-posts').show();
  });

  $('body').on('click', '.select-search-posts', function(event) {
    event.preventDefault();
    $('.search').show();
    $('.search-form').attr('action', 'posts');
    $('.input-search').attr('placeholder', I18n.t('search_posts'));
    $('.input-search').focus();
    $('.select-search-posts').hide();
    $('.select-search-users').show();
  });
});
