require 'rails_helper'

RSpec.describe Players::HomeController, :player_authenticated,
               type: :controller do
  it { is_expected.to be_kind_of(Players::BaseController) }

  describe 'GET index' do
    before do
      process :index, method: :get
    end

    it { expect(response).to render_template('index') }
    it { expect(assigns(:on_game_matches)).to be_decorated }
    it { expect(assigns(:awaiting_challenge)).to be_decorated }
    it { expect(assigns(:last_matches)).to be_decorated }
  end
end
