// Loads all Semantic javascripts
//= require semantic-ui

// ドロップダウンを使用するためのコード
$(document).on('turbolinks:load', function () {
  $('.ui.dropdown').dropdown();

  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
});
