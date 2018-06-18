require 'rails_helper'

RSpec.describe Matches::GameBoardsController, :player_authenticated,
               type: :controller do
  let(:match) { create(:match, :setting_game_board) }

  let(:game_board) do
    create(:game_board, match: match, player: current_player)
  end

  describe 'GET show' do
    before do
      process :show, method: :get, params: {
        id: game_board.id,
        match_id: match.id
      }
    end

    it { expect(response).to render_template('show') }
    it { expect(assigns(:game_board)).to eq(game_board) }
    it { expect(assigns(:game_board)).to be_decorated }
    it { expect(assigns(:match)).to eq(match) }
  end

  describe 'GET edit' do
    before do
      process :edit, method: :get, params: {
        id: game_board.id,
        match_id: match.id
      }
    end

    it { expect(response).to render_template('edit') }
    it { expect(assigns(:game_board)).to eq(game_board) }
    it { expect(assigns(:match)).to eq(match) }
  end

  describe 'PATCH update' do
    let(:optional_scenery_background) { create(:scenery_background) }

    let(:game_board_params) do
      Hash[scenery_background_id: optional_scenery_background.id]
    end

    context 'when is a request xhr' do
      before do
        match.scenery.optional_backgrounds << optional_scenery_background
        match.scenery.save!

        process :update, method: :patch, xhr: true, params: {
          id: game_board.id,
          match_id: match.id,
          game_board: game_board_params
        }
      end

      it do
        expect do
          game_board.reload
        end.to change(game_board, :scenery_background_id)
      end
    end

    context 'when is not a request xhr' do
      before do
        process :update, method: :patch, xhr: false, params: {
          id: game_board.id,
          match_id: match.id,
          game_board: game_board_params
        }
      end

      it { expect(response).to redirect_to(:root) }
    end
  end
end
