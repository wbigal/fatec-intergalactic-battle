# == Schema Information
#
# Table name: scenery_backgrounds
#
#  id                 :bigint(8)        not null, primary key
#  name               :string(50)       not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe SceneryBackground, type: :model do
  include ActionDispatch::TestProcess

  it 'has a valid factory' do
    image = fixture_file_upload('scenaries/images/background.jpg', 'image/jpeg')
    expect(create(:scenery_background, image: image)).to be_valid
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  describe '#image' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_attachment_size(:image).less_than(2.megabyte) }

    it do
      is_expected.to validate_attachment_content_type(:image).allowing(
        'image/jpg',
        'image/jpeg'
      )
    end
  end
end
