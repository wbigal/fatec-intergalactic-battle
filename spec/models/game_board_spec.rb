# == Schema Information
#
# Table name: game_boards
#
#  id                    :bigint(8)        not null, primary key
#  player_id             :bigint(8)        not null
#  match_id              :bigint(8)        not null
#  scenery_background_id :bigint(8)        not null
#  ready_to_play         :boolean          default(FALSE), not null
#  rows                  :integer          not null
#  columns               :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe GameBoard, type: :model do
  it 'has a valid factory' do
    expect(create(:game_board)).to be_valid
  end

  describe '#player' do
    it { is_expected.to belong_to(:player) }
  end

  describe '#match' do
    it { is_expected.to belong_to(:match) }
  end

  describe '#scenery_background' do
    it { is_expected.to belong_to(:scenery_background) }
  end

  describe '#spacecraft_positions' do
    it { is_expected.to have_many(:spacecraft_positions) }
  end

  describe '#dropped_bombs' do
    it { is_expected.to have_many(:dropped_bombs) }
  end

  describe '#rows' do
    it { is_expected.to validate_presence_of(:rows) }

    it do
      is_expected.to validate_numericality_of(:rows).
        only_integer.is_greater_than_or_equal_to(10).
        is_less_than_or_equal_to(20)
    end
  end

  describe '#columns' do
    it { is_expected.to validate_presence_of(:columns) }

    it do
      is_expected.to validate_numericality_of(:columns).
        only_integer.is_greater_than_or_equal_to(10).
        is_less_than_or_equal_to(20)
    end
  end

  describe '#configure_scenery_background' do
    context 'when background is blank' do
      let(:game_board) { build(:game_board) }
      let(:scenery) { game_board.match.scenery }

      it do
        expect do
          game_board.save
          game_board.reload
        end.to change(game_board, :scenery_background).to(scenery.background)
      end
    end

    context 'when background is not blank' do
      let(:scenery_background) { create(:scenery_background) }
      let(:game_board) do
        build(:game_board, scenery_background: scenery_background)
      end

      it do
        expect do
          game_board.save
          game_board.reload
        end.not_to change(game_board, :scenery_background)
      end
    end
  end

  describe '#configure_scenery_background' do
    let(:game_board) { build(:game_board) }
    let(:scenery) { game_board.match.scenery }

    it do
      expect do
        game_board.save
        game_board.reload
      end.to change(game_board, :rows).to(scenery.rows)
    end

    it do
      expect do
        game_board.save
        game_board.reload
      end.to change(game_board, :columns).to(scenery.columns)
    end
  end
end
