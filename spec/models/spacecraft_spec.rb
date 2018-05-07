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

require 'rails_helper'

RSpec.describe Spacecraft, type: :model do
  include ActionDispatch::TestProcess

  it 'has a valid factory' do
    image = fixture_file_upload(
      'spacecraft_shapes/templates/shape.png',
      'image/png'
    )
    expect(create(:spacecraft, image: image)).to be_valid
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  describe '#team' do
    it { is_expected.to belong_to(:team) }
  end

  describe '#shape' do
    it { is_expected.to belong_to(:shape) }
  end
end
