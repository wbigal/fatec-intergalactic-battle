require 'rails_helper'

RSpec.describe Players::MatchesController, type: :routing do
  describe '#new' do
    it { expect(get: 'players/matches/new').to route_to('players/matches#new') }
  end

  describe '#create' do
    it { expect(post: 'players/matches').to route_to('players/matches#create') }
  end

  describe '#awaiting_challenge' do
    it do
      expect(get: 'players/matches/1910/awaiting_challenge').to route_to(
        'players/matches#awaiting_challenge',
        match_id: '1910'
      )
    end
  end
end
