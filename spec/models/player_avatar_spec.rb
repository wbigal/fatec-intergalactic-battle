require 'rails_helper'

RSpec.describe PlayerAvatar, type: :model do
  include ActionDispatch::TestProcess

  it 'has a valid factory' do
    image = fixture_file_upload('players/images/avatar.png', 'image/png')
    expect(create(:player_avatar, image: image)).to be_valid
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  describe '#image' do
    it { is_expected.to respond_to(:image) }
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
