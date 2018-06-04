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
#

class Match < ApplicationRecord
  belongs_to :player
  belongs_to :player_team, class_name: 'Team',
                           foreign_key: 'player_team_id',
                           inverse_of: 'matches'

  belongs_to :challenger, class_name: 'Player',
                          foreign_key: 'challenger_id',
                          inverse_of: 'challenger_matches',
                          optional: true

  belongs_to :challenger_team, class_name: 'Team',
                               foreign_key: 'challenger_team_id',
                               inverse_of: 'challenger_matches'

  belongs_to :winner, class_name: 'Player',
                      foreign_key: 'winner_id',
                      inverse_of: 'wins',
                      optional: true

  belongs_to :scenery

  validate :invalid_winner

  scope :awaiting_challenge, -> { where(challenger_id: nil, started_at: nil) }

  def awaiting_challenge?
    challenger_id.blank? && started_at.blank?
  end

  def occurring?
    !awaiting_challenge? && ended_at.blank?
  end

  private

  def invalid_winner
    return if winner.blank?
    errors.add(:winner_id, :invalid_winner) \
    if player != winner && challenger != winner
  end
end
