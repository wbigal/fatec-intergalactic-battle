module Players
  class HomeController < BaseController
    before_action :load_on_game_matches
    before_action :load_awaiting_challenge
    before_action :load_last_matches

    def index; end

    private

    def load_on_game_matches
      @on_game_matches = Players::GameBoardDecorator.decorate_collection(
        current_player.game_boards.joins(:match).where(
          matches: { status: %w[setting_game_board playing] }
        )
      )
    end

    def load_awaiting_challenge
      @awaiting_challenge =
        Players::AwaitingChallengeDecorator.decorate_collection(
          current_player.matches.where(status: 'awaiting_challenge')
        )
    end

    def load_last_matches
      @last_matches = Players::GameBoardDecorator.decorate_collection(
        current_player.game_boards.joins(:match).where(
          matches: { status: 'game_over' }
        ).limit(12)
      )
    end
  end
end
