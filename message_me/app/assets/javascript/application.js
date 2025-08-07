// Loads all Semantic javascripts
//= require semantic-ui

// ドロップダウンを使用するためのコード
$(document).on('turbolinks:load', function () {
  $('.ui.dropdown').dropdown();
});