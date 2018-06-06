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
    belongs_to :game_board
    belongs_to :spacecraft

    delegate :match, to: :game_board, allow_nil: true
    delegate :scenery, to: :match, allow_nil: true

    validate :row_out_of_range
    validate :column_out_of_range
    validates :row, presence: true, numericality: { only_integer: true }
    validates :column, presence: true, numericality: { only_integer: true }

    private

    def row_out_of_range
      return if scenery.blank?
      errors.add(:row, :row_out_of_range) \
      if row.negative? || row >= scenery.rows
    end

    def column_out_of_range
      return if scenery.blank?
      errors.add(:column, :column_out_of_range) \
      if column.negative? || column >= scenery.columns
    end
  end
end
