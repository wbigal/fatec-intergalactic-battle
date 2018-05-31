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

require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'has a valid factory' do
    expect(create(:player)).to be_valid
  end

  describe '#nickname' do
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_length_of(:nickname).is_at_most(20) }
    it do
      create(:player)
      is_expected.to validate_uniqueness_of(:nickname).case_insensitive
    end
  end

  describe '#avatar' do
    it { is_expected.to belong_to(:avatar) }
  end

  describe '#matches' do
    it { is_expected.to have_many(:matches) }
  end

  describe '#challenger_matches' do
    it { is_expected.to have_many(:challenger_matches) }
  end

  describe '#wins' do
    it { is_expected.to have_many(:wins) }
  end
end
