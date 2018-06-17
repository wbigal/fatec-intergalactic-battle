require 'rails_helper'

RSpec.describe Matches::SpacecraftPositionDecorator do
  let(:spacecraft_position) { create(:game_boards_spacecraft_position) }
  subject { Matches::SpacecraftPositionDecorator.decorate(spacecraft_position) }

  describe '#spacecraft_id' do
    it do
      expect(subject.spacecraft_id).to eq(spacecraft_position.spacecraft.id)
    end
  end

  describe '#row' do
    it { expect(subject.row).to eq(spacecraft_position.row) }
  end

  describe '#column' do
    it { expect(subject.row).to eq(spacecraft_position.column) }
  end

  describe '#image_url' do
    it do
      expect(subject.image_url).to eq(spacecraft_position.spacecraft.image.url)
    end
  end
end
