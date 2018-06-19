$(document).ready(function(){
  $('.capsule').click(function(event){
    $(event.target).find('input[type=radio]').prop('checked', true);
    $('#selectTeam').modal();
  })
});