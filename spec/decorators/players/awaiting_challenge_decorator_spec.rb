require 'rails_helper'

RSpec.describe Players::AwaitingChallengeDecorator do
  let(:match) { create(:match) }
  subject { Players::AwaitingChallengeDecorator.decorate(match) }

  describe '#player_team' do
    it { expect(subject.player_team).to eq(match.player_team) }
  end

  describe '#player_team_name' do
    it { expect(subject.player_team_name).to eq(match.player_team.name) }
  end

  describe '#match_url' do
    it do
      expect(subject.match_url).to eq("/matches/#{match.id}/awaiting_challenge")
    end
  end

  describe '#scenery_description' do
    let(:scenery) { match.scenery }
    let(:expected) { "#{scenery.name} - #{scenery.rows}x#{scenery.columns}" }
    it { expect(subject.scenery_description).to eq(expected) }
  end
end
