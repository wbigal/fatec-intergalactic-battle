module GameBoards
  module SpacecraftPositions
    class MatchIsNotSettingGameBoard < StandardError; end
    class Create < ServiceBase
      attr_reader :game_board
      attr_reader :spacecraft
      attr_reader :row
      attr_reader :column

      delegate :match, to: :game_board

      def initialize(game_board:, spacecraft:, row:, column:)
        @game_board = game_board
        @spacecraft = spacecraft
        @row = row
        @column = column
      end

      def call
        raise MatchIsNotSettingGameBoard, 'Match is not settting game board.' \
        unless match.setting_game_board?
        GameBoards::SpacecraftPosition.transaction do
          create_spacecraft_positions
        end
      end

      private

      def create_spacecraft_positions
        spacecraft_positions.each do |spacecraft_position|
          create_spacecraft_position(
            row: spacecraft_position.first,
            column: spacecraft_position.second
          )
        end
      end

      def create_spacecraft_position(row:, column:)
        GameBoards::SpacecraftPosition.create!(
          game_board: @game_board,
          spacecraft: @spacecraft,
          row: row,
          column: column
        )
      end

      def spacecraft_positions
        JSON.parse(@spacecraft.shape.targets).map do |item|
          [item.first + @row, item.second + @column]
        end
      end
    end
  end
end
