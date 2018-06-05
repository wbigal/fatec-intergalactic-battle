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

FactoryBot.define do
  factory :game_boards_spacecraft_position,
          class: 'GameBoards::SpacecraftPosition' do
    game_board
    spacecraft
    row 10
    column 10
  end
end
