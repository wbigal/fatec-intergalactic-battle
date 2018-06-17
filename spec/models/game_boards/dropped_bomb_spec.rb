# == Schema Information
#
# Table name: game_boards_dropped_bombs
#
#  id                                 :bigint(8)        not null, primary key
#  game_board_id                      :bigint(8)        not null
#  game_boards_spacecraft_position_id :bigint(8)
#  row                                :integer          not null
#  column                             :integer          not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#

require 'rails_helper'

RSpec.describe GameBoards::DroppedBomb, type: :model do
  it_behaves_like 'localizable_target'

  it 'has a valid factory' do
    expect(create(:game_boards_dropped_bomb)).to be_valid
  end

  describe '#game_board' do
    it { is_expected.to belong_to(:game_board) }
  end

  describe '#spacecraft_position' do
    it { is_expected.to belong_to(:spacecraft_position) }
  end
end
