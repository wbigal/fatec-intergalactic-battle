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

    delegate :match, to: :game_board, allow_nil: true
    delegate :scenery, to: :match, allow_nil: true
  end
end
