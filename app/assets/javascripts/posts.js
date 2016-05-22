// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


var loadFile = function(event) {
  var output = document.getElementById('image-preview');
  output.src = URL.createObjectURL(event.target.files[0]);
};

$(document).ready(function() {
  if (!$('#load_more').length//) {
                || $('#load_more').length < 1) {
    $('#paginator').remove();
  };
});
