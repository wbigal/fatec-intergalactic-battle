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

FactoryBot.define do
  factory :game_boards_dropped_bomb, class: 'GameBoards::DroppedBomb' do
    game_board
    row 0
    column 0
  end
end
