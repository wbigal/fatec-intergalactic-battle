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

module GameBoards
  class DroppedBomb < ApplicationRecord
    include LocalizableTarget

    belongs_to :game_board
    belongs_to :spacecraft_position,
               foreign_key: 'game_boards_spacecraft_position_id',
               inverse_of: 'dropped_bomb',
               optional: true

    delegate :match, to: :game_board, allow_nil: true
    delegate :scenery, to: :match, allow_nil: true
  end
end
