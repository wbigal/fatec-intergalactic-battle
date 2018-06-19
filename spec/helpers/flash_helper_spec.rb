require 'rails_helper'

RSpec.describe FlashHelper, type: :helper do
  describe '#flash_class' do
    context 'when level is notice' do
      it { expect(helper.flash_class(:notice)).to eq('alert alert-info') }
    end

    context 'when level is success' do
      it { expect(helper.flash_class(:success)).to eq('alert alert-success') }
    end

    context 'when level is error' do
      it { expect(helper.flash_class(:error)).to eq('alert alert-danger') }
    end

    context 'when level is alert' do
      it { expect(helper.flash_class(:alert)).to eq('alert alert-warning') }
    end

    context 'when level is nil' do
      it { expect(helper.flash_class(nil)).to be_nil }
    end
  end
end
