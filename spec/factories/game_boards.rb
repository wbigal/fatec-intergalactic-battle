# == Schema Information
#
# Table name: game_boards
#
#  id                    :bigint(8)        not null, primary key
#  player_id             :bigint(8)        not null
#  match_id              :bigint(8)        not null
#  scenery_background_id :bigint(8)        not null
#  ready_to_play         :boolean          default(FALSE), not null
#  rows                  :integer          not null
#  columns               :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryBot.define do
  factory :game_board do
    player
    match { association(:match, :in_game, player: player) }
    ready_to_play false
  end
end
