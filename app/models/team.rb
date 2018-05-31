# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ApplicationRecord
  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }

  has_many :matches, class_name: 'Match',
                     foreign_key: 'player_team_id',
                     inverse_of: 'player_team',
                     dependent: :restrict_with_error

  has_many :challenger_matches, class_name: 'Match',
                                foreign_key: 'challenger_team_id',
                                inverse_of: 'challenger_team',
                                dependent: :restrict_with_error
end
