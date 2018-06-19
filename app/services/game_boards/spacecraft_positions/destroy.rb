module GameBoards
  module SpacecraftPositions
    class MatchIsNotSettingGameBoard < StandardError; end
    class Destroy < ServiceBase
      attr_reader :game_board
      attr_reader :row
      attr_reader :column

      delegate :match, to: :game_board

      def initialize(game_board:, row:, column:)
        @game_board = game_board
        @row = row
        @column = column
      end

      def call
        raise MatchIsNotSettingGameBoard, 'Match is not settting game board.' \
        unless match.setting_game_board?
        spacecraft_positions.delete_all
      end

      private

      def spacecraft_positions
        @game_board.spacecraft_positions.where(spacecraft_id: spacecraft_id)
      end

      def spacecraft_id
        @spacecraft_id ||= @game_board.spacecraft_positions.find_by!(
          row: @row,
          column: @column
        )&.spacecraft_id
      end
    end
  end
end
