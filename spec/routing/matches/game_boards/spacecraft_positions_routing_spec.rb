require 'rails_helper'

RSpec.describe Matches::GameBoards::SpacecraftPositionsController,
               type: :routing do
  describe '#new' do
    it do
      expect(
        get: '/matches/1/game_boards/2/spacecraft_positions/new'
      ).to route_to(
        'matches/game_boards/spacecraft_positions#new',
        match_id: '1',
        game_board_id: '2'
      )
    end
  end

  describe '#create' do
    it do
      expect(post: '/matches/1/game_boards/2/spacecraft_positions').to route_to(
        'matches/game_boards/spacecraft_positions#create',
        match_id: '1',
        game_board_id: '2'
      )
    end
  end

  describe '#destroy' do
    it do
      expect(
        delete: '/matches/1/game_boards/2/spacecraft_positions/' \
                'position/row/3/column/4'
      ).to route_to(
        'matches/game_boards/spacecraft_positions#destroy',
        match_id: '1',
        game_board_id: '2',
        row: '3',
        column: '4'
      )
    end
  end
end
