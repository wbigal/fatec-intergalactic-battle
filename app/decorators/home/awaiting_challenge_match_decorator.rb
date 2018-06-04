module Home
  class AwaitingChallengeMatchDecorator < Draper::Decorator
    delegate :player, to: :object
    delegate :nickname, to: :player, prefix: true
    delegate :player_team, to: :object
    delegate :name, to: :player_team, prefix: true
    delegate :scenery, to: :object

    def player_avatar_url
      player.avatar.image.url(:large)
    end

    def scenery_description
      "#{scenery.name} - #{scenery.rows}x#{scenery.columns}"
    end

    def join_url
      Rails.application.routes.url_helpers.match_join_path(object)
    end
  end
end
