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

  describe '#team' do
    it { is_expected.to belong_to(:team) }
  end

  describe '#shape' do
    it { is_expected.to belong_to(:shape) }
  end

  describe '#sceneries' do
    it { is_expected.to have_and_belong_to_many(:sceneries) }
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it do
      create(:spacecraft)
      is_expected.to validate_uniqueness_of(:name).case_insensitive
    end
  end

  describe '#full_description' do
    context 'when shape is blank' do
      subject { build(:spacecraft, name: 'Spacecraft', shape: nil) }
      it { expect(subject.full_description).to eq('Spacecraft') }
    end

    context 'when team is blank' do
      subject { build(:spacecraft, name: 'Spacecraft', team: nil) }
      it { expect(subject.full_description).to eq('Spacecraft') }
    end

    context 'when shape and team is present' do
      let(:team) { build(:team, name: 'Team') }
      let(:shape) do
        build(:spacecraft_shape, spacecraft_width: 10, spacecraft_height: 20)
      end

      subject do
        build(:spacecraft, name: 'Spacecraft', team: team, shape: shape)
      end

      it do
        expect(subject.full_description).to eq('Team | Spacecraft - 10x20px')
      end
    end
  end
end
