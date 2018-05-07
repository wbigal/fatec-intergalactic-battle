# == Schema Information
#
# Table name: players
#
#  id                     :bigint(8)        not null, primary key
#  player_avatar_id       :bigint(8)        not null
#  nickname               :string(20)       not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :nickname, presence: true,
                       length: { maximum: 20 },
                       uniqueness: { case_sensitive: false }

  belongs_to :avatar, class_name: 'PlayerAvatar',
                      foreign_key: 'player_avatar_id',
                      inverse_of: 'players'
end
