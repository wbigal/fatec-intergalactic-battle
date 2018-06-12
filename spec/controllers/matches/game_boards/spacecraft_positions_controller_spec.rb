require 'rails_helper'

RSpec.describe Matches::GameBoards::SpacecraftPositionsController,
               :player_authenticated, type: :controller do
  let(:match) { create(:match, :setting_game_board) }
  let(:spacecrafts) { match.scenery.spacecrafts }
  let!(:game_board) do
    create(:game_board, match: match, player: current_player)
  end

  describe 'GET new' do
    context 'when there are not spacecraft_positions' do
      let(:spacecraft_positions) { [] }

      before do
        process :new, method: :get, xhr: true, params: {
          game_board_id: game_board.id,
          match_id: match.id
        }
      end

      it { expect(response).to render_template('new') }
      it { expect(assigns(:spacecrafts)).to match_array(spacecrafts) }
      it { expect(assigns(:match)).to eq(match) }
      it { expect(assigns(:game_board)).to eq(game_board) }

      it do
        expect(assigns(:spacecraft_form)).to be_an_instance_of(
          Matches::GameBoards::SpacecraftForm
        )
      end

      it do
        expect(assigns(:spacecraft_positions)).to match_array(
          spacecraft_positions
        )
      end
    end

    context 'when there are spacecraft_positions' do
      let!(:spacecraft_position) do
        create(:game_boards_spacecraft_position, game_board: game_board)
      end

      let(:spacecraft_positions) { [spacecraft_position] }

      let(:expected_spacecraft_positions) do
        spacecraft_positions.group_by(&:spacecraft_id)
      end

      before do
        process :new, method: :get, xhr: true, params: {
          game_board_id: game_board.id,
          match_id: match.id
        }
      end

      it { expect(response).to render_template('new') }
      it { expect(assigns(:spacecrafts)).to match_array(spacecrafts) }
      it { expect(assigns(:match)).to eq(match) }
      it { expect(assigns(:game_board)).to eq(game_board) }

      it do
        expect(assigns(:spacecraft_form)).to be_an_instance_of(
          Matches::GameBoards::SpacecraftForm
        )
      end

      it do
        expect(assigns(:spacecraft_positions)).to match_array(
          expected_spacecraft_positions
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
      let(:spacecraft_form_params) do
        Hash[spacecraft_id: spacecrafts.sample, row: '2', column: '3']
      end

      it do
        expect do
          process :create, method: :post, xhr: true, params: {
            game_board_id: game_board.id,
            match_id: match.id,
            matches_game_boards_spacecraft_form: spacecraft_form_params
          }
        end.to change(GameBoards::SpacecraftPosition, :count)
      end
    end

    context 'when params are invalids' do
      let(:spacecraft_form_params) do
        Hash[spacecraft_id: nil, row: nil, column: nil]
      end

      it do
        expect do
          process :create, method: :post, xhr: true, params: {
            game_board_id: game_board.id,
            match_id: match.id,
            matches_game_boards_spacecraft_form: spacecraft_form_params
          }
        end.not_to change(GameBoards::SpacecraftPosition, :count)
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
