require 'rails_helper'

RSpec.describe Matches::GameBoardsController, type: :routing do
  describe '#show' do
    it do
      expect(get: '/matches/1/game_boards/2').to route_to(
        'matches/game_boards#show', match_id: '1', id: '2'
      )
    end
  end

  describe '#edit' do
    it do
      expect(get: '/matches/1/game_boards/2/edit').to route_to(
        'matches/game_boards#edit', match_id: '1', id: '2'
      )
    end
  end

  describe '#update' do
    it do
      expect(patch: '/matches/1/game_boards/2').to route_to(
        'matches/game_boards#update', match_id: '1', id: '2'
      )
    end
  end
end
