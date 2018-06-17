module Matches
  module GameBoards
    class DropBombsController < BaseController
      before_action -> { redirect_to(:root) unless request.xhr? }
      before_action :load_dropped_bombs_by_me

      def new
        @drop_bomb_form = Matches::GameBoards::DropBombForm.new
        @my_turn = my_turn?
        render :new, layout: false
      end

      def create
        @drop_bomb_form = Matches::GameBoards::DropBombForm.new(
          drop_bomb_params
        )

        if @drop_bomb_form.valid?
          create_dropped_bombed
          render :create, status: :created
        else
          render :create, status: :unprocessable_entity
        end
      end

      private

      def my_turn?
        ::Matches::NextPlayer.call(@match) == current_player
      end

      def load_dropped_bombs_by_me
        @dropped_bombs_by_me =
          Matches::DroppedBombDecorator.decorate_collection(
            other_game_board.dropped_bombs
          )
      end

      def other_game_board
        GameBoard.where(match: @match).where.not(player: current_player).first
      end

      def create_dropped_bombed
        ::GameBoards::DropBombs::Create.call(
          player: current_player,
          match: @match,
          row: @drop_bomb_form.row,
          column: @drop_bomb_form.column
        )
      end

      def game_board_id
        params[:game_board_id]
      end

      def drop_bomb_params
        params.require(:matches_game_boards_drop_bomb_form).permit(
          :row, :column
        )
      end
    end
  end
end
