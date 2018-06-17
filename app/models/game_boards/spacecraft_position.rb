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

module GameBoards
  class SpacecraftPosition < ApplicationRecord
    include LocalizableTarget

    belongs_to :game_board
    belongs_to :spacecraft

    has_one :dropped_bomb, foreign_key: 'game_boards_spacecraft_position_id',
                           inverse_of: 'spacecraft_position',
                           dependent: :restrict_with_error

    delegate :match, to: :game_board, allow_nil: true
    delegate :scenery, to: :match, allow_nil: true
  end
end
