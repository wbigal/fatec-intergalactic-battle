# == Schema Information
#
# Table name: game_boards_spacecraft_positions
#
#  id            :bigint(8)        not null, primary key
#  game_board_id :bigint(8)        not null
#  spacecraft_id :bigint(8)        not null
#  row           :integer          not null
#  column        :integer          not null
#  targeted      :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe GameBoards::SpacecraftPosition, type: :model do
  it_behaves_like 'localizable_target'

  it 'has a valid factory' do
    expect(create(:game_boards_spacecraft_position)).to be_valid
  end

  describe '#game_board' do
    it { is_expected.to belong_to(:game_board) }
  end

  describe '#spacecraft' do
    it { is_expected.to belong_to(:spacecraft) }
  end

  describe '#dropped_bomb' do
    it { is_expected.to have_one(:dropped_bomb) }
  end

  describe '#match' do
    it { is_expected.to respond_to(:match) }
  end
end
