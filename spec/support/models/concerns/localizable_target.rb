shared_examples_for 'localizable_target' do
  describe '#scenery' do
    it { is_expected.to respond_to(:scenery) }
  end

  describe '#row' do
    it { is_expected.to validate_presence_of(:row) }
    it { is_expected.to validate_numericality_of(:row).only_integer }
  end

  describe '#column' do
    it { is_expected.to validate_presence_of(:column) }
    it { is_expected.to validate_numericality_of(:column).only_integer }
  end
end
