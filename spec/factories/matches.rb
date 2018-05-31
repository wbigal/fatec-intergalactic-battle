# == Schema Information
#
# Table name: matches
#
#  id                 :bigint(8)        not null, primary key
#  player_id          :bigint(8)        not null
#  player_team_id     :integer          not null
#  challenger_id      :integer
#  challenger_team_id :integer          not null
#  scenery_id         :bigint(8)        not null
#  winner_id          :integer
#  started_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :match do
    player
    player_team { association(:team) }
    challenger_team { association(:team) }
    scenery { association(:scenery, :with_spacecrafts) }
  end
end
