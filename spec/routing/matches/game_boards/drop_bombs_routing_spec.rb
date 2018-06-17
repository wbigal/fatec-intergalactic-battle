require 'rails_helper'

RSpec.describe Matches::GameBoards::SpacecraftPositionsController,
               type: :routing do
  describe '#new' do
    it do
      expect(get: '/matches/1/game_boards/2/drop_bombs/new').to route_to(
        'matches/game_boards/drop_bombs#new',
        match_id: '1',
        game_board_id: '2'
      )
    end
  end

  describe '#create' do
    it do
      expect(post: '/matches/1/game_boards/2/drop_bombs').to route_to(
        'matches/game_boards/drop_bombs#create',
        match_id: '1',
        game_board_id: '2'
      )
    end
  end
end
