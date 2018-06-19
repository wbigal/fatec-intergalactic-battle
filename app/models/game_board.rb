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

class GameBoard < ApplicationRecord
  belongs_to :player
  belongs_to :match
  belongs_to :scenery_background

  has_many :spacecraft_positions, class_name: 'GameBoards::SpacecraftPosition',
                                  dependent: :destroy

  has_many :dropped_bombs, class_name: 'GameBoards::DroppedBomb',
                           dependent: :destroy

  before_validation :configure_rows_and_columns, on: :create
  before_validation :configure_scenery_background, on: :create

  validates :rows, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 10,
    less_than_or_equal_to: 20
  }

  validates :columns, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 10,
    less_than_or_equal_to: 20
  }

  private

  def configure_rows_and_columns
    return if match.blank?
    self.rows = match.scenery.rows
    self.columns = match.scenery.columns
  end

  def configure_scenery_background
    return if match.blank? || scenery_background.present?
    self.scenery_background = match.scenery.background
  end
end
