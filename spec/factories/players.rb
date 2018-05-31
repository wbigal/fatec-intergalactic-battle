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

FactoryBot.define do
  factory :player do
    nickname
    email
    password '123@mudar'
    avatar { association(:player_avatar) }
  end
end
