require 'rails_helper'

RSpec.describe Players::GameBoardDecorator do
  let(:match) { create(:match, :in_game) }
  let(:game_board) { create(:game_board, match: match) }
  subject { Players::GameBoardDecorator.decorate(game_board) }

  describe '#player' do
    it { expect(subject.player).to eq(match.player) }
  end

  describe '#player_nickname' do
    it { expect(subject.player_nickname).to eq(match.player.nickname) }
  end

  describe '#player_avatar_url' do
    it do
      expect(subject.player_avatar_url).to eq(
        match.player.avatar.image.url(:large)
      )
    end
  end

  describe '#challenger' do
    it { expect(subject.challenger).to eq(match.challenger) }
  end

  describe '#challenger_nickname' do
    it { expect(subject.challenger_nickname).to eq(match.challenger.nickname) }
  end

  describe '#challenger_avatar_url' do
    it do
      expect(subject.challenger_avatar_url).to eq(
        match.challenger.avatar.image.url(:large)
      )
    end
  end

  describe '#match_url' do
    context 'when match\'s status is setting_game_board' do
      let(:match) { create(:match, :setting_game_board) }

      it do
        expect(subject.match_url).to eq(
          "/matches/#{match.id}/game_boards/#{game_board.id}/edit"
        )
      end
    end

    context 'when match\'s status is playing' do
      let(:match) { create(:match, :in_game) }

      it do
        expect(subject.match_url).to eq(
          "/matches/#{match.id}/game_boards/#{game_board.id}"
        )
      end
    end

    context 'when match\'s status is game_over' do
      let(:match) { create(:match, :over) }

      it do
        expect(subject.match_url).to eq(
          "/matches/#{match.id}/game_boards/#{game_board.id}"
        )
      end
    end
  end

  describe '#action' do
    context 'when match\'s status is setting_game_board' do
      let(:match) { create(:match, :setting_game_board) }
      it { expect(subject.action).to eq('Configurar Tabuleiro') }
    end

    context 'when match\'s status is playing' do
      let(:match) { create(:match, :in_game) }
      it { expect(subject.action).to eq('Voltar ao Jogo') }
    end
  end

  describe '#won_or_lost' do
    context 'when player won' do
      let(:match) { create(:match, :over) }
      it { expect(subject.won_or_lost(match.winner)).to eq('Você Ganhou') }
    end

    context 'when player lost' do
      let(:match) { create(:match, :over) }
      it { expect(subject.won_or_lost(match.challenger)).to eq('Você Perdeu') }
    end

    context 'when match is not over' do
      let(:match) { create(:match, :in_game) }
      it { expect(subject.won_or_lost(match.challenger)).to be_nil }
    end
  end
end
