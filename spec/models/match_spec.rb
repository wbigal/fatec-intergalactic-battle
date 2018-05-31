# == Schema Information
#
# Table name: matches
#
#  id                 :bigint(8)        not null, primary key
#  player_id          :bigint(8)        not null
#  player_team_id     :integer          not null
#  challenger_id      :integer
#  challenger_team_id :integer          not null
#  scenery_id         :bigint(8)        not null
#  winner_id          :integer
#  started_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Match, type: :model do
  it 'has a valid factory' do
    expect(create(:match)).to be_valid
  end

  describe '#player' do
    it { is_expected.to belong_to(:player) }
  end

  describe '#player_team' do
    it { is_expected.to belong_to(:player_team) }
  end

  describe '#challenger' do
    it { is_expected.to belong_to(:challenger) }
  end

  describe '#challenger_team' do
    it { is_expected.to belong_to(:challenger_team) }
  end

  describe '#scenery' do
    it { is_expected.to belong_to(:scenery) }
  end

  describe '#winner' do
    it { is_expected.to belong_to(:winner) }
  end

  describe '#started_at' do
    it { is_expected.to respond_to(:started_at) }
  end

  describe '.awaiting_challenge' do
    let!(:match_awaiting_challenge) { create(:match) }
    let!(:match_in_game) { create(:match, :in_game) }

    it { expect(Match.awaiting_challenge).to eq([match_awaiting_challenge]) }
  end
end
