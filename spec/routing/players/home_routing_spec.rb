require 'rails_helper'

RSpec.describe Players::HomeController, type: :routing do
  describe '#index' do
    it { expect(get: 'players/my-page').to route_to('players/home#index') }
  end
end
