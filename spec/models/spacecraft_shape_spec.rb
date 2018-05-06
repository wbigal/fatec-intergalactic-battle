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

require 'rails_helper'

RSpec.describe SpacecraftShape, type: :model do
  include ActionDispatch::TestProcess

  it 'has a valid factory' do
    expect(create(:spacecraft_shape)).to be_valid
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  describe '#targets' do
    it { is_expected.to validate_presence_of(:targets) }
  end

  describe '#spacecraft_width' do
    it { is_expected.to validate_presence_of(:spacecraft_width) }

    it do
      is_expected.to validate_numericality_of(:spacecraft_width).
        only_integer.is_less_than_or_equal_to(532).
        is_greater_than_or_equal_to(50)
    end
  end

  describe '#spacecraft_height' do
    it { is_expected.to validate_presence_of(:spacecraft_height) }

    it do
      is_expected.to validate_numericality_of(:spacecraft_height).
        only_integer.is_less_than_or_equal_to(402).
        is_greater_than_or_equal_to(50)
    end
  end

  describe '#template' do
    it { is_expected.to validate_presence_of(:template) }

    it do
      is_expected.to validate_attachment_size(:template).less_than(2.megabyte)
    end

    it do
      is_expected.to validate_attachment_content_type(:template).allowing(
        'image/png'
      )
    end
  end
end
