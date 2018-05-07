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

require 'rails_helper'

RSpec.describe Scenery, type: :model do
  include ActionDispatch::TestProcess

  it 'has a valid factory' do
    expect(create(:scenery)).to be_valid
  end

  describe '#spacecrafts' do
    it { is_expected.to have_and_belong_to_many(:spacecrafts) }
  end

  describe '#background' do
    it { is_expected.to belong_to(:background) }
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it do
      create(:scenery)
      is_expected.to validate_uniqueness_of(:name).case_insensitive
    end
  end

  describe '#rows' do
    it { is_expected.to validate_presence_of(:rows) }

    it do
      is_expected.to validate_numericality_of(:rows).
        only_integer.is_greater_than_or_equal_to(10).
        is_less_than_or_equal_to(20)
    end
  end

  describe '#columns' do
    it { is_expected.to validate_presence_of(:columns) }

    it do
      is_expected.to validate_numericality_of(:columns).
        only_integer.is_greater_than_or_equal_to(10).
        is_less_than_or_equal_to(20)
    end
  end
end
