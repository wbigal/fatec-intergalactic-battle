module Matches
  class GameBoardsController < GameBoards::BaseController
    before_action -> { redirect_to(:root) unless request.xhr? }, only: [:update]
    before_action :load_scenery_backgrounds

    def edit; end

    def update
      if @game_board.update(scenery_background_params)
        render :update, locals: { success: true }, status: :success
      else
        render :update, locals: { success: false },
                        status: :unprocessable_entity
      end
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
  end
end
