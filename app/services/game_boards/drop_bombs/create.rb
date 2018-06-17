module GameBoards
  module DropBombs
    class Create < ServiceBase
      attr_reader :player
      attr_reader :match
      attr_reader :row
      attr_reader :column

      def initialize(player:, match:, row:, column:)
        @player = player
        @match = match
        @row = row
        @column = column
      end

      def call
        GameBoards::DroppedBomb.transaction do
          create_dropped_bomb
        end
      end

      private

      def create_dropped_bomb
        GameBoards::DroppedBomb.create!(
          game_board: other_game_board,
          spacecraft_position: targeted_spacecraft_position,
          row: @row,
          column: @column
        )
      end

      def other_game_board
        @other_game_board ||= GameBoard.where(match: @match).
                              where.not(player: @player).first
      end

      def targeted_spacecraft_position
        return if spacecraft_position.blank?
        spacecraft_position.update(targeted: true)
        spacecraft_position
      end

      def spacecraft_position
        @spacecraft_position ||= GameBoards::SpacecraftPosition.find_by(
          game_board: other_game_board,
          row: @row,
          column: @column
        )
      end
    end
  end
end
