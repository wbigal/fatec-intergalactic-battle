# == Schema Information
#
# Table name: player_avatars
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

RSpec.describe PlayerAvatar, type: :model do
  include ActionDispatch::TestProcess

  it 'has a valid factory' do
    image = fixture_file_upload('players/images/avatar.png', 'image/png')
    expect(create(:player_avatar, image: image)).to be_valid
  end

  describe '#players' do
    it { is_expected.to have_many(:players) }
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it do
      create(:player_avatar)
      is_expected.to validate_uniqueness_of(:name).case_insensitive
    end
  end

  describe '#image' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_attachment_size(:image).less_than(2.megabyte) }

    it do
      is_expected.to validate_attachment_content_type(:image).allowing(
        'image/jpg',
        'image/jpeg',
        'image/gif',
        'image/png'
      )
    end
  end
end
