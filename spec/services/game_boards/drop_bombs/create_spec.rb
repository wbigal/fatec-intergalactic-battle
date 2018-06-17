require 'rails_helper'

RSpec.describe GameBoards::DropBombs::Create, type: :service do
  describe '#call' do
    let(:match) { create(:match, :in_game) }
    let(:current_player) { match.player }

    let!(:game_board) do
      create(:game_board, match: match, player: current_player)
    end

    let(:other_game_board) do
      create(:game_board, match: match, player: match.challenger)
    end

    let(:row) { 5 }
    let(:column) { 0 }

    let(:wrong_row) { 4 }
    let(:wrong_column) { 0 }

    let!(:spacecraft_position) do
      create(:game_boards_spacecraft_position, game_board: other_game_board,
                                               row: row,
                                               column: column)
    end

    context 'when the bomb is dropped on target' do
      it do
        expect do
          GameBoards::DropBombs::Create.call(
            player: current_player,
            match: match,
            row: row,
            column: column
          )
        end.to change(GameBoards::DroppedBomb, :count).from(0).to(1)
      end

      describe 'spacecraft_position targeted' do
        before do
          GameBoards::DropBombs::Create.call(
            player: current_player,
            match: match,
            row: row,
            column: column
          )
        end

        it do
          expect do
            spacecraft_position.reload
          end.to change(spacecraft_position, :targeted).from(false).to(true)
        end
      end
    end

    context 'when the bomb is not dropped on target' do
      it do
        expect do
          GameBoards::DropBombs::Create.call(
            player: current_player,
            match: match,
            row: wrong_row,
            column: wrong_column
          )
        end.to change(GameBoards::DroppedBomb, :count).from(0).to(1)
      end

      describe 'spacecraft_position targeted' do
        before do
          GameBoards::DropBombs::Create.call(
            player: current_player,
            match: match,
            row: wrong_row,
            column: wrong_column
          )
        end

        it do
          expect do
            spacecraft_position.reload
          end.not_to change(spacecraft_position, :targeted)
        end
      end
    end
  end
end
