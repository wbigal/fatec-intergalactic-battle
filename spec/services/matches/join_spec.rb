require 'rails_helper'

RSpec.describe Matches::Join, type: :service do
  describe '#call' do
    let(:match) { create(:match) }
    let(:challenger) { current_player }

    it do
      expect do
        Matches::Join.call(match: match, challenger: challenger)
      end.to change(GameBoard, :count).from(0).to(2)
    end
  end
end
