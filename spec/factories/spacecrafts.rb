# == Schema Information
#
# Table name: spacecrafts
#
#  id                  :bigint(8)        not null, primary key
#  team_id             :bigint(8)        not null
#  spacecraft_shape_id :bigint(8)        not null
#  name                :string(50)       not null
#  image_file_name     :string
#  image_content_type  :string
#  image_file_size     :integer
#  image_updated_at    :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :spacecraft do
    team
    association(:shape, factory: :spacecraft_shape)
    name
    image_file_name 'just-a-pic.png'
    image_content_type 'image/png'
    image_file_size 2
    image_updated_at Time.new(2015, 8, 18).utc
  end
end
