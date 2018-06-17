module Matches
  class NextPlayer < ServiceBase
    attr_reader :match

    def initialize(match)
      @match = match
    end

    def call
      next_player
    end

    private

    def next_player
      return @match.challenger if last_player_bombed.blank?
      last_player_bombed
    end

    def last_player_bombed
      @last_player_bombed ||= Player.joins(game_boards: :dropped_bombs).
                              where(game_boards: { match_id: match.id }).
                              order('game_boards_dropped_bombs.created_at').
                              last
    end
  end
end
