$(document).ready(function(){
  $('.capsule').click(function(){
    $(this).find('input[type=radio]').prop('checked', true);
    $('#selectTeam').modal();
  })
});