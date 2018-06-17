require 'rails_helper'

RSpec.describe Matches::GameBoardDecorator do
  let(:game_board) { create(:game_board) }

  let!(:spacecraft_position) do
    create(:game_boards_spacecraft_position, game_board: game_board)
  end

  subject { Matches::GameBoardDecorator.decorate(game_board) }

  describe '#background_url' do
    it do
      expect(subject.background_url).to eq(
        game_board.match.scenery.background.image.url(:large)
      )
    end
  end

  describe '#spacecraft_positions' do
    it { expect(subject.spacecraft_positions.keys.size).to eq(1) }

    it do
      expect(subject.spacecraft_positions.keys.first).to eq(
        spacecraft_position.spacecraft.id
      )
    end
  end
end
