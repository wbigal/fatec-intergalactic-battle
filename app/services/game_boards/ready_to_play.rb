module GameBoards
  class ReadyToPlay < ServiceBase
    attr_reader :game_board

    delegate :match, to: :game_board
    delegate :player, to: :game_board

    def initialize(game_board)
      @game_board = game_board
    end

    def call
      GameBoard.transaction do
        update_ready_to_play
      end
    end

    private

    def update_ready_to_play
      game_board.update(ready_to_play: true)
      match.play! if other_game_board.ready_to_play
    end

    def other_game_board
      @other_game_board ||= GameBoard.where(match: match).
                            where.not(player: player).first
    end
  end
end
