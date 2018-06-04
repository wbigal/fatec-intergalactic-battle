require 'rails_helper'

RSpec.describe MatchesController, type: :routing do
  describe '#new' do
    it { expect(get: 'matches/new').to route_to('matches#new') }
  end

  describe '#create' do
    it { expect(post: 'matches').to route_to('matches#create') }
  end

  describe '#awaiting_challenge' do
    it do
      expect(get: 'matches/1910/awaiting_challenge').to route_to(
        'matches#awaiting_challenge',
        match_id: '1910'
      )
    end
  end

  describe '#join' do
    it do
      expect(post: 'matches/1910/join').to route_to(
        'matches#join',
        match_id: '1910'
      )
    end
  end
end
