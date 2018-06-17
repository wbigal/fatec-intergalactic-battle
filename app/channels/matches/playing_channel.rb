module Matches
  class PlayingChannel < ApplicationCable::Channel
    def subscribed
      match_id = params[:match_id]
      game_board_id = params[:game_board_id]
      stream_from "matches_playing_#{match_id}_#{game_board_id}"
    end

    def unsubscribed; end
  end
end
