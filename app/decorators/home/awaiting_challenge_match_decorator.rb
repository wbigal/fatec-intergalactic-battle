module Home
  class AwaitingChallengeMatchDecorator < Draper::Decorator
    delegate :player, to: :object
    delegate :nickname, to: :player, prefix: true
    delegate :player_team, to: :object
    delegate :name, to: :player_team, prefix: true

    def player_avatar_url
      player.avatar.image.url(:large)
    end
  end
end
