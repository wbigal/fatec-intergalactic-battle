require 'rails_helper'

RSpec.describe Home::AwaitingChallengeMatchDecorator do
  let(:match) { create(:match) }
  subject { Home::AwaitingChallengeMatchDecorator.decorate(match) }

  describe '#player' do
    it { expect(subject.player).to eq(match.player) }
  end

  describe '#player_nickname' do
    it { expect(subject.player_nickname).to eq(match.player.nickname) }
  end

  describe '#player_team' do
    it { expect(subject.player_team).to eq(match.player_team) }
  end

  describe '#player_team_name' do
    it { expect(subject.player_team_name).to eq(match.player_team.name) }
  end

  describe '#player_avatar_url' do
    it do
      expect(subject.player_avatar_url).to eq(
        match.player.avatar.image.url(:large)
      )
    end
  end

  describe '#scenery_description' do
    let(:scenery) { match.scenery }
    let(:expected) { "#{scenery.name} - #{scenery.rows}x#{scenery.columns}" }
    it { expect(subject.scenery_description).to eq(expected) }
  end
end
