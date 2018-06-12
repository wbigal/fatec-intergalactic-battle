require 'rails_helper'

RSpec.describe Matches::GameBoards::SpacecraftForm, type: :form do
  it { is_expected.to be_kind_of(ActiveModel::Model) }

  describe '#spacecraft_id' do
    it { is_expected.to validate_presence_of(:spacecraft_id) }
  end

  describe '#row' do
    it { is_expected.to validate_presence_of(:row) }
    it do
      is_expected.to validate_numericality_of(:row).
        only_integer.is_greater_than_or_equal_to(0)
    end
  end

  describe '#column' do
    it { is_expected.to validate_presence_of(:column) }
    it do
      is_expected.to validate_numericality_of(:column).
        only_integer.is_greater_than_or_equal_to(0)
    end
  end
end
