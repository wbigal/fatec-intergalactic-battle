module Matches
  class Join < ServiceBase
    attr_reader :match
    attr_reader :challenger

    def initialize(match:, challenger:)
      @match = match
      @challenger = challenger
    end

    def call
      Match.transaction { join_and_create_boards }
    end

    private

    def join_and_create_boards
      @match.join_challenger!(@challenger)
      @match.game_boards.create!(player: @match.player)
      @match.game_boards.create!(player: @challenger)
    end
  end
end
