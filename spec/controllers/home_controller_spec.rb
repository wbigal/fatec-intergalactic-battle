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
    #
    #
    # it { expect(assigns(:activity_area)).to eq(activity_area) }
    # it { expect(assigns(:page)).to eq(activity_area.page) }
    # it { expect(assigns(:activity_areas).object).to eq(activity_areas) }
    # it { expect(assigns(:activity_area)).to be_decorated }
    # it { expect(assigns(:page)).to be_decorated }
    # it { expect(assigns(:activity_areas)).to be_decorated }
  end
end
