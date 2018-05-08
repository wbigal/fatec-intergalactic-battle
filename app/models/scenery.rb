# == Schema Information
#
# Table name: sceneries
#
#  id                    :bigint(8)        not null, primary key
#  name                  :string(50)       not null
#  rows                  :integer          not null
#  columns               :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  scenery_background_id :bigint(8)
#

class Scenery < ApplicationRecord
  MINIMUM_OF_SPACECRAFTS_PER_TEAM = 3
  MINIMUM_OF_SPACECRAFTS = MINIMUM_OF_SPACECRAFTS_PER_TEAM * 2
  MAXIMUM_OF_SPACECRAFTS_PER_TEAM = 6
  MAXIMUM_OF_SPACECRAFTS = MAXIMUM_OF_SPACECRAFTS_PER_TEAM * 2

  belongs_to :background, class_name: 'SceneryBackground',
                          foreign_key: 'scenery_background_id',
                          inverse_of: 'sceneries'

  has_and_belongs_to_many :spacecrafts

  has_and_belongs_to_many :optional_backgrounds,
                          class_name: 'SceneryBackground',
                          foreign_key: 'scenery_id'

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }

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

  validate :invalid_quantity_of_spacecrafts
  validates_with Validators::Sceneries::IncompatibleShapes
  validates_with Validators::Sceneries::InvalidQuantityOfSpacecraftsPerTeam

  private

  def invalid_quantity_of_spacecrafts
    if spacecrafts.size < MINIMUM_OF_SPACECRAFTS ||
       spacecrafts.size > MAXIMUM_OF_SPACECRAFTS
      errors.add(:spacecrafts, :invalid_quantity_of_spacecrafts)
    end
  end
end
