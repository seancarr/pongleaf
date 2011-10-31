$(document).ready( function(){
  $('#winner_name').autocomplete('/players');
  $('#loser_name').autocomplete('/players');
  $('.tab-bar').tabs();
});
