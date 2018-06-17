require 'rails_helper'

RSpec.describe Matches::GameBoards::DropBombsController,
               :player_authenticated, type: :controller do
  let(:match) { create(:match, :in_game) }

  let!(:game_board) do
    create(:game_board, match: match, player: current_player)
  end

  let(:other_game_board) do
    create(:game_board, match: match, player: match.challenger)
  end

  before do
    create(:game_boards_dropped_bomb, game_board: other_game_board)
    create(:game_boards_dropped_bomb, game_board: game_board)
  end

  describe 'GET new' do
    context 'when is a request xhr' do
      before do
        process :new, method: :get, xhr: true, params: {
          game_board_id: game_board.id,
          match_id: match.id
        }
      end

      it { expect(response).to render_template('new') }
      it { expect(assigns(:match)).to eq(match) }
      it { expect(assigns(:game_board)).to eq(game_board) }
      it { expect(assigns(:dropped_bombs_by_me)).to be_decorated }

      it do
        expect(assigns(:drop_bomb_form)).to be_an_instance_of(
          Matches::GameBoards::DropBombForm
        )
      end
    end

    context 'when is not a request xhr' do
      before do
        process :new, method: :get, xhr: false, params: {
          game_board_id: game_board.id,
          match_id: match.id
        }
      end

      it { expect(response).to redirect_to(:root) }
    end
  end

  describe 'POST create' do
    context 'when is a request xhr' do
      let(:drop_bomb_form_params) { Hash[row: '2', column: '3'] }

      it do
        expect do
          process :create, method: :post, xhr: true, params: {
            game_board_id: game_board.id,
            match_id: match.id,
            matches_game_boards_drop_bomb_form: drop_bomb_form_params
          }
        end.to change(GameBoards::DroppedBomb, :count)
      end

      describe 'assigns dropped_bombs_by_me' do
        before do
          process :create, method: :post, xhr: true, params: {
            game_board_id: game_board.id,
            match_id: match.id,
            matches_game_boards_drop_bomb_form: drop_bomb_form_params
          }
        end

        it { expect(assigns(:dropped_bombs_by_me)).to be_decorated }
        it { expect(assigns(:dropped_bombs_by_me).count).to eq(2) }
      end
    end

    context 'when params are invalids' do
      let(:drop_bomb_form_params) { Hash[row: nil, column: nil] }

      it do
        expect do
          process :create, method: :post, xhr: true, params: {
            game_board_id: game_board.id,
            match_id: match.id,
            matches_game_boards_drop_bomb_form: drop_bomb_form_params
          }
        end.not_to change(GameBoards::DroppedBomb, :count)
      end

      describe 'assigns dropped_bombs_by_me' do
        before do
          process :create, method: :post, xhr: true, params: {
            game_board_id: game_board.id,
            match_id: match.id,
            matches_game_boards_drop_bomb_form: drop_bomb_form_params
          }
        end

        it { expect(assigns(:dropped_bombs_by_me)).to be_decorated }
        it { expect(assigns(:dropped_bombs_by_me).count).to eq(1) }
      end
    end

    context 'when is not a request xhr' do
      before do
        process :create, method: :post, xhr: false, params: {
          game_board_id: game_board.id,
          match_id: match.id
        }
      end

      it { expect(response).to redirect_to(:root) }
    end
  end
end
