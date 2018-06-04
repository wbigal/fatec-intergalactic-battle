require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    before do
      process :index, method: :get
    end

    context 'when there are matches' do
      let(:awaiting_challenge) { [create(:match)] }

      it { expect(response).to render_template('index') }
      it { expect(assigns(:awaiting_challenge)).to eq(awaiting_challenge) }
      it { expect(assigns(:awaiting_challenge)).to be_decorated }
    end

    context 'when there are not matches' do
      it { expect(response).to render_template('index') }
      it { expect(assigns(:awaiting_challenge)).to be_blank }
    end
  end
end
