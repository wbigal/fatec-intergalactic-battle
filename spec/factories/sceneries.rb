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

FactoryBot.define do
  factory :scenery do
    name  'Scenery'
    rows 10
    columns 10
    background { association(:scenery_background) }
  end
end
