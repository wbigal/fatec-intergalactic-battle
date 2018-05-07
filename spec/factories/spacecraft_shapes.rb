# == Schema Information
#
# Table name: spacecraft_shapes
#
#  id                    :bigint(8)        not null, primary key
#  name                  :string(50)       not null
#  template_file_name    :string
#  template_content_type :string
#  template_file_size    :integer
#  template_updated_at   :datetime
#  targets               :json             not null
#  spacecraft_width      :integer          not null
#  spacecraft_height     :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryBot.define do
  factory :spacecraft_shape do
    name
    spacecraft_width 50
    spacecraft_height 50
    targets [[0, 0], [0, 1], [0, 2]].to_json
    template_file_name 'just-a-pic.png'
    template_content_type 'image/png'
    template_file_size 2
    template_updated_at Time.new(2015, 8, 18).utc
  end
end
