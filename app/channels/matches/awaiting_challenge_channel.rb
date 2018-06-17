module Matches
  class AwaitingChallengeChannel < ApplicationCable::Channel
    def subscribed
      stream_from "matches_awaiting_challenge_match_#{params[:match_id]}"
    end

    def unsubscribed; end
  end
end
