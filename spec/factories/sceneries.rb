# == Schema Information
#
# Table name: sceneries
#
#  id                    :bigint(8)        not null, primary key
#  name                  :string(50)       not null
#  rows                  :integer          not null
#  columns               :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  scenery_background_id :bigint(8)
#

FactoryBot.define do
  factory :scenery do
    name
    rows 10
    columns 10
    association(:background, factory: :scenery_background)

    trait :with_spacecrafts do
      spacecrafts do
        team_one = create(:team)
        team_two = create(:team)
        shape = create(:spacecraft_shape)
        (1..12).map do |i|
          create(:spacecraft, shape: shape,
                              team: i.even? ? team_one : team_two)
        end
      end
    end
  end
end
