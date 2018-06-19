module Players
  class GameBoardDecorator < Draper::Decorator
    delegate :match, to: :object
    delegate :player, to: :match
    delegate :nickname, to: :player, prefix: true
    delegate :challenger, to: :match
    delegate :nickname, to: :challenger, prefix: true

    def player_avatar_url
      player.avatar.image.url(:large)
    end

    def challenger_avatar_url
      challenger.avatar.image.url(:large)
    end

    def match_url
      if match.setting_game_board?
        edit_match_game_board_url
      elsif match.playing? || match.game_over?
        match_game_board_url
      end
    end

    def action
      if match.setting_game_board?
        'Configurar Tabuleiro'
      elsif match.playing?
        'Voltar ao Jogo'
      end
    end

    def won_or_lost(current_player)
      return unless match.game_over?
      return 'Você Ganhou' if match.winner == current_player
      'Você Perdeu'
    end

    private

    def edit_match_game_board_url
      Rails.application.routes.url_helpers.edit_match_game_board_path(
        id: object,
        match_id: match.id
      )
    end

    def match_game_board_url
      Rails.application.routes.url_helpers.match_game_board_path(
        id: object,
        match_id: match.id
      )
    end
  end
end
