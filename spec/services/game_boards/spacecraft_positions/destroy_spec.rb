require 'rails_helper'

RSpec.describe GameBoards::SpacecraftPositions::Destroy, type: :service do
  describe '#call' do
    let(:match) { create(:match, :setting_game_board) }
    let(:game_board) { create(:game_board, match: match) }

    let(:spacecraft_shape) do
      create(:spacecraft_shape, targets: [[0, 0], [0, 1], [0, 2]].to_json)
    end

    let(:spacecraft) { create(:spacecraft, shape: spacecraft_shape) }

    before do
      create(:game_boards_spacecraft_position, game_board: game_board,
                                               spacecraft: spacecraft,
                                               row: 0,
                                               column: 0)

      create(:game_boards_spacecraft_position, game_board: game_board,
                                               spacecraft: spacecraft,
                                               row: 0,
                                               column: 1)

      create(:game_boards_spacecraft_position, game_board: game_board,
                                               spacecraft: spacecraft,
                                               row: 0,
                                               column: 2)

      create(:game_boards_spacecraft_position, row: 0, column: 2)
    end

    it do
      expect do
        GameBoards::SpacecraftPositions::Destroy.call(
          game_board: game_board,
          row: 0,
          column: 2
        )
      end.to change(GameBoards::SpacecraftPosition, :count).from(4).to(1)
    end
  end
end
