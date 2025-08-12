// Loads all Semantic javascripts
//= require semantic-ui

scroll_bottom = function() {
  if ($('#messages').length > 0) {
    $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}

// ドロップダウンを使用するためのコード
$(document).on('turbolinks:load', function() {
  $('.ui.dropdown').dropdown();

  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });

  scroll_bottom();
});
