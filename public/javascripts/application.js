$(document).ready( function(){
  $('#new_match input[type=text]').autocomplete('/players');
  $('.tab-bar').tabs();
  
  // Hide flash messages after 30 seconds
  window.setTimeout(function() {  
    $('#flash-messages').hide();
  }, 30000);
});
