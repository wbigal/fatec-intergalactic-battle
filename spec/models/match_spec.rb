# == Schema Information
#
# Table name: matches
#
#  id                    :bigint(8)        not null, primary key
#  player_id             :bigint(8)        not null
#  player_team_id        :integer          not null
#  challenger_id         :integer
#  challenger_team_id    :integer          not null
#  scenery_id            :bigint(8)        not null
#  winner_id             :integer
#  started_at            :datetime
#  ended_at              :datetime
#  total_time_in_seconds :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
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

  describe '#ended_at' do
    it { is_expected.to respond_to(:ended_at) }
  end

  describe '#total_time_in_seconds' do
    it { is_expected.to respond_to(:total_time_in_seconds) }
  end

  describe '#awaiting_challenge?' do
    context 'when the player is awaiting for challenger' do
      let(:match) { create(:match, :awaiting_challenge) }
      it { expect(match.awaiting_challenge?).to be_truthy }
    end

    context 'when the match is in game' do
      let(:match) { create(:match, :in_game) }
      it { expect(match.awaiting_challenge?).to be_falsy }
    end

    context 'when the match is over' do
      let(:match) { create(:match, :over) }
      it { expect(match.awaiting_challenge?).to be_falsy }
    end
  end

  describe '#occurring?' do
    context 'when the player is awaiting for challenger' do
      let(:match) { create(:match, :awaiting_challenge) }
      it { expect(match.occurring?).to be_falsy }
    end

    context 'when the match is in game' do
      let(:match) { create(:match, :in_game) }
      it { expect(match.occurring?).to be_truthy }
    end

    context 'when the match is over' do
      let(:match) { create(:match, :over) }
      it { expect(match.occurring?).to be_falsy }
    end
  end

  describe '#invalid_winner' do
    let(:player_one) { create(:player) }
    let(:player_two) { create(:player) }
    let(:player_three) { create(:player) }

    context 'when the winner is the player one' do
      let(:match) do
        build(:match, :in_game, player: player_one,
                                challenger: player_two,
                                winner: player_one)
      end

      it { expect(match.save).to be_truthy }
    end

    context 'when the winner is the player two' do
      let(:match) do
        build(:match, :in_game, player: player_one,
                                challenger: player_two,
                                winner: player_two)
      end

      it { expect(match.save).to be_truthy }
    end

    context 'when the winner is the other player' do
      let(:match) do
        build(:match, :in_game, player: player_one,
                                challenger: player_two,
                                winner: player_three)
      end

      it { expect(match.save).to be_falsy }
    end
  end

  describe '#challenger_and_player_are_same_person' do
    let(:player_one) { create(:player) }
    let(:player_two) { create(:player) }

    context 'when the player and challenger are diffenrents' do
      let(:match) do
        build(:match, :in_game, player: player_one,
                                challenger: player_two)
      end

      it { expect(match.save).to be_truthy }
    end

    context 'when the player and challenger are same person' do
      let(:match) do
        build(:match, :in_game, player: player_one,
                                challenger: player_one)
      end

      it { expect(match.save).to be_falsy }
    end
  end

  describe '.awaiting_challenge' do
    let!(:match_awaiting_challenge) { create(:match) }
    let!(:match_in_game) { create(:match, :in_game) }

    it { expect(Match.awaiting_challenge).to eq([match_awaiting_challenge]) }
  end
end
