# == Schema Information
#
# Table name: matches
#
#  id                    :bigint(8)        not null, primary key
#  player_id             :bigint(8)        not null
#  player_team_id        :integer          not null
#  challenger_id         :integer
#  challenger_team_id    :integer          not null
#  scenery_id            :bigint(8)        not null
#  winner_id             :integer
#  started_at            :datetime
#  ended_at              :datetime
#  total_time_in_seconds :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  status                :string(50)       not null
#

FactoryBot.define do
  factory :match do
    player
    player_team { association(:team) }
    challenger_team { association(:team) }
    scenery { association(:scenery, :with_spacecrafts) }

    trait :in_game do
      challenger { association(:player) }
      started_at Time.now.utc
      status 'playing'
    end

    trait :setting_game_board do
      challenger { association(:player) }
      status 'setting_game_board'
    end

    trait :awaiting_challenge do
      status 'awaiting_challenge'
    end

    trait :over do
      challenger { association(:player) }
      started_at Time.now.utc
      ended_at Time.now.utc
      winner { player }
      status 'game_over'
    end
  end
end
