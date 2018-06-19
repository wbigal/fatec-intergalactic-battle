$(document).ready(function(){
  $('#game-board-form .background-image').click(function(){
    let img = $(this).clone()
    let backId = $(this).attr('data-background-id')
    $('#selectBackground').find('#game_board_scenery_background_id').val(backId)
    $('#selectBackground').find('.image img').remove()
    $('#selectBackground').find('.image').append($(img))
    $('#selectBackground').modal();    
  })

  $('#selectBackground input').click(function(){
    let img = $('#selectBackground').find('img')
    $('body').css('background-image', 'url(' + $(img).attr('src') + ')')
  });
});
