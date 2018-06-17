module Players
  class AwaitingChallengeDecorator < Draper::Decorator
    delegate :player_team, to: :object
    delegate :name, to: :player_team, prefix: true
    delegate :scenery, to: :object

    def scenery_description
      "#{scenery.name} - #{scenery.rows}x#{scenery.columns}"
    end

    def match_url
      Rails.application.routes.url_helpers.match_awaiting_challenge_path(
        match_id: object
      )
    end
  end
end
