module Matches
  module GameBoards
    class DropBombsController < BaseController
      before_action -> { redirect_to(:root) unless request.xhr? }
      before_action :load_dropped_bombs_by_me
      before_action :load_dropped_bombs_on_me

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

      def load_dropped_bombs_on_me
        @dropped_bombs_on_me =
          Matches::DroppedBombDecorator.decorate_collection(
            @game_board.dropped_bombs
          )
      end

      def other_game_board
        GameBoard.where(match: @match).where.not(player: current_player).first
      end

      def create_dropped_bombed
        dropped_bomb = ::GameBoards::DropBombs::Create.call(
          player: current_player,
          match: @match,
          row: @drop_bomb_form.row,
          column: @drop_bomb_form.column
        )
        define_winner
        update_other_game_board(dropped_bomb.game_board)
      end

      def define_winner
        ::Matches::SomeoneWin.call(@match)
      end

      def game_board_id
        params[:game_board_id]
      end

      def drop_bomb_params
        params.require(:matches_game_boards_drop_bomb_form).permit(
          :row, :column
        )
      end

      def update_other_game_board(other_game_board)
        ActionCable.server.broadcast(
          "matches_playing_#{params[:match_id]}_#{other_game_board.id}",
          render_url: new_match_game_board_drop_bomb_path(
            game_board_id: other_game_board
          )
        )
      end
    end
  end
end
