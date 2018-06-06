require 'rails_helper'

RSpec.describe GameBoards::SpacecraftPositions::Create, type: :service do
  describe '#call' do
    let(:game_board) { create(:game_board) }

    let(:spacecraft_shape) do
      create(:spacecraft_shape, targets: [[0, 0], [0, 1], [0, 2]].to_json)
    end

    let(:spacecraft) { create(:spacecraft, shape: spacecraft_shape) }

    it do
      expect do
        GameBoards::SpacecraftPositions::Create.call(
          game_board: game_board,
          spacecraft: spacecraft,
          row: 0,
          column: 0
        )
      end.to change(GameBoards::SpacecraftPosition, :count).from(0).to(3)
    end
  end
end
