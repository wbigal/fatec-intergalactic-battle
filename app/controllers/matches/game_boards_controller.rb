module Matches
  class GameBoardsController < GameBoards::BaseController
    before_action -> { redirect_to(:root) unless request.xhr? }, only: [:update]
    before_action :load_game_board, except: %i[show]
    before_action :load_scenery_backgrounds, except: %i[show]

    def show
      game_board = @match.game_boards.find_by!(id: game_board_id,
                                               player: current_player)

      @game_board = Matches::GameBoardDecorator.decorate(game_board)
    end

    def edit
      redirect_to root_path unless @match.setting_game_board?
    end

    def update
      if @game_board.update(scenery_background_params)
        render :update, locals: { success: true }, status: :success
      else
        render :update, locals: { success: false },
                        status: :unprocessable_entity
      end
    end

    def ready
      ::GameBoards::ReadyToPlay.call(@game_board)
      update_other_game_board
      redirect_to match_game_board_path(id: @game_board)
    end

    private

    def spacecraft_params
      params.require(:game_board).permit(:scenery_background_id)
    end

    def load_scenery_backgrounds
      @scenery_backgrounds = @match.scenery.optional_backgrounds
    end

    def scenery_background_params
      background_id = spacecraft_params[:scenery_background_id].presence ||
                      @match.scenery.background.id
      Hash[scenery_background_id: background_id]
    end

    def update_other_game_board
      ActionCable.server.broadcast(
        "matches_playing_#{params[:match_id]}_#{other_game_board.id}",
        render_url: new_match_game_board_drop_bomb_path(
          game_board_id: other_game_board
        )
      )
    end

    def other_game_board
      @other_game_board ||= GameBoard.where(match: @match).
                            where.not(id: @game_board).
                            first
    end
  end
end
