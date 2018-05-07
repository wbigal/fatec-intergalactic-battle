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
  belongs_to :background, class_name: 'SceneryBackground',
                          foreign_key: 'scenery_background_id',
                          inverse_of: 'sceneries'

  has_and_belongs_to_many :spacecrafts

  validates :name, presence: true, length: { maximum: 50 }

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
end
