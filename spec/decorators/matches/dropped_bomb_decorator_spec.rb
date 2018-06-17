require 'rails_helper'

RSpec.describe Matches::DroppedBombDecorator do
  let(:dropped_bomb) { create(:game_boards_dropped_bomb) }
  subject { Matches::DroppedBombDecorator.decorate(dropped_bomb) }

  describe '#row' do
    it { expect(subject.row).to eq(dropped_bomb.row) }
  end

  describe '#column' do
    it { expect(subject.row).to eq(dropped_bomb.column) }
  end

  describe '#on_target?' do
    it { expect(subject.on_target?).to eq(dropped_bomb.on_target?) }
  end
end
