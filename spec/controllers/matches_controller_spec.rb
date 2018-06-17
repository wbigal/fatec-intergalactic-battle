require 'rails_helper'

RSpec.describe MatchesController, :player_authenticated,
               type: :controller do
  let!(:teams) { Team.all }
  let!(:sceneries) { [create(:scenery, :with_spacecrafts)] }

  describe 'GET new' do
    before do
      process :new, method: :get
    end

    it { expect(response).to render_template('new') }
    it { expect(assigns(:match)).to be_a_new(Match) }
    it { expect(assigns(:teams)).to match_array(teams) }
    it { expect(assigns(:sceneries)).to eq(sceneries) }
  end

  describe 'POST create' do
    context 'when correct params are present' do
      let(:match_params) do
        Hash[
          scenery_id: sceneries.sample.id,
          player_team_id: teams.sample.id
        ]
      end

      it do
        expect do
          process :create, method: :post, params: { match: match_params }
        end.to change(Match, :count).from(0).to(1)
      end

      it do
        process :create, method: :post, params: { match: match_params }
        expect(response).to redirect_to(
          match_awaiting_challenge_path(Match.last)
        )
      end
    end

    context 'when scenery_id is not present' do
      let(:match_params) do
        Hash[
          scenery_id: nil,
          player_team_id: teams.sample.id
        ]
      end

      it do
        expect do
          process :create, method: :post, params: { match: match_params }
        end.not_to change(Match, :count)
      end
    end
  end

  describe 'GET awaiting_challenge' do
    context 'when match is awaiting for challenger' do
      let!(:match) { create(:match, player: current_player) }

      before do
        process :awaiting_challenge, method: :get,
                                     params: { match_id: match.id }
      end

      it { expect(response).to render_template('awaiting_challenge') }
      it { expect(assigns(:match)).to eq(match) }
    end

    context 'when match does not exist' do
      let!(:match) { create(:match) }

      before do
        process :awaiting_challenge, method: :get,
                                     params: { match_id: match.id }
      end

      it { expect(response).to redirect_to(new_match_path) }
    end
  end

  describe 'POST join' do
    context 'when match is awaiting for challenger' do
      let(:match) { create(:match, :awaiting_challenge) }

      it do
        expect do
          process :join, method: :post, params: { match_id: match.id }
          match.reload
        end.to change(match, :challenger).from(nil).to(current_player)
      end

      it do
        process :join, method: :post, params: { match_id: match.id }
        expect(response).to redirect_to(
          edit_match_game_board_path(
            id: match.game_boards.find_by(player: current_player)
          )
        )
      end
    end

    context 'when match is in game' do
      let(:match) { create(:match, :in_game) }

      it do
        expect do
          process :join, method: :post, params: { match_id: match.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the player and challenger are same person' do
      let(:player) { current_player }
      let(:match) { create(:match, :awaiting_challenge, player: player) }

      it do
        expect do
          process :join, method: :post, params: { match_id: match.id }
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
