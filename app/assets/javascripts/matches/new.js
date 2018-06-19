$(document).ready(function(){
  $('.capsule').click(function(event){
    let sceneryId = $(this).find("#match_scenery_id").val()
    $('#selectTeam').find('#match_scenery_id').val(sceneryId)
    $('#selectTeam').modal();
  })
});