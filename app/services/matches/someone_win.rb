module Matches
  class SomeoneWin < ServiceBase
    attr_reader :match
    attr_reader :first_game_board
    attr_reader :second_game_board

    def initialize(match)
      @match = match
      @first_game_board = @match.game_boards.first
      @second_game_board = @match.game_boards.second
      @winner = nil
    end

    def call
      return if winner.blank?
      match.winner!(winner)
      winner
    end

    private

    def winner
      return @winner if @winner.present?

      if all_bombed_spacecraft_positions?(@first_game_board)
        @winner = @second_game_board.player
      elsif all_bombed_spacecraft_positions?(@second_game_board)
        @winner = @first_game_board.player
      end

      @winner
    end

    def all_bombed_spacecraft_positions?(game_board)
      game_board.spacecraft_positions.where(targeted: false).none?
    end
  end
end
