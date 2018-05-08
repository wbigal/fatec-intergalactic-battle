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

require 'rails_helper'

RSpec.describe Scenery, type: :model do
  include ActionDispatch::TestProcess

  it 'has a valid factory' do
    expect(create(:scenery, :with_spacecrafts)).to be_valid
  end

  describe '#spacecrafts' do
    it { is_expected.to have_and_belong_to_many(:spacecrafts) }
  end

  describe '#background' do
    it { is_expected.to belong_to(:background) }
  end

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it do
      create(:scenery, :with_spacecrafts)
      is_expected.to validate_uniqueness_of(:name).case_insensitive
    end
  end

  describe '#rows' do
    it { is_expected.to validate_presence_of(:rows) }

    it do
      is_expected.to validate_numericality_of(:rows).
        only_integer.is_greater_than_or_equal_to(10).
        is_less_than_or_equal_to(20)
    end
  end

  describe '#columns' do
    it { is_expected.to validate_presence_of(:columns) }

    it do
      is_expected.to validate_numericality_of(:columns).
        only_integer.is_greater_than_or_equal_to(10).
        is_less_than_or_equal_to(20)
    end
  end

  describe '#invalid_quantity_of_spacecrafts' do
    let(:background) { create(:scenery_background) }
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:shape) { create(:spacecraft_shape) }
    let(:spacecrafts) { first_team_spacecrafts.concat(second_team_spacecrafts) }

    let(:scenery_attributes) do
      attributes_for(:scenery, scenery_background_id: background.id,
                               spacecrafts: spacecrafts)
    end

    context 'when the quantity is corrent' do
      let!(:first_team_spacecrafts) do
        (1..3).map { create(:spacecraft, team: team_one, shape: shape) }
      end

      let!(:second_team_spacecrafts) do
        (1..3).map { create(:spacecraft, team: team_two, shape: shape) }
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.to change(Scenery, :count).from(0).to(1)
      end
    end

    context 'when the quantity is less than minimum' do
      let!(:first_team_spacecrafts) do
        [create(:spacecraft, team: team_one)]
      end

      let!(:second_team_spacecrafts) do
        [create(:spacecraft, team: team_two)]
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.not_to change(Scenery, :count)
      end
    end

    context 'when the quantity is greater than maximum' do
      let!(:first_team_spacecrafts) do
        (1..7).map { create(:spacecraft, team: team_one) }
      end

      let!(:second_team_spacecrafts) do
        (1..7).map { create(:spacecraft, team: team_two) }
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.not_to change(Scenery, :count)
      end
    end

    context 'when just one team is present' do
      let(:first_team_spacecrafts) do
        (1..6).map { create(:spacecraft, team: team_one) }
      end

      let(:second_team_spacecrafts) { [] }

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.not_to change(Scenery, :count)
      end
    end
  end

  describe '#invalid_quantity_of_spacecrafts_per_team' do
    let(:background) { create(:scenery_background) }
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:shape_one) { create(:spacecraft_shape) }
    let(:shape_two) { create(:spacecraft_shape) }
    let(:spacecrafts) { first_team_spacecrafts.concat(second_team_spacecrafts) }

    let(:scenery_attributes) do
      attributes_for(:scenery, scenery_background_id: background.id,
                               spacecrafts: spacecrafts)
    end

    context 'when the quantity is corrent' do
      let(:first_team_spacecrafts) do
        first_team_spacecrafts_with_shape_one.concat(
          first_team_spacecrafts_with_shape_two
        )
      end

      let(:second_team_spacecrafts) do
        second_team_spacecrafts_with_shape_one.concat(
          second_team_spacecrafts_with_shape_two
        )
      end

      let!(:first_team_spacecrafts_with_shape_one) do
        (1..2).map { create(:spacecraft, team: team_one, shape: shape_one) }
      end

      let!(:first_team_spacecrafts_with_shape_two) do
        (1..2).map { create(:spacecraft, team: team_one, shape: shape_two) }
      end

      let!(:second_team_spacecrafts_with_shape_one) do
        (1..2).map { create(:spacecraft, team: team_two, shape: shape_one) }
      end

      let!(:second_team_spacecrafts_with_shape_two) do
        (1..2).map { create(:spacecraft, team: team_two, shape: shape_two) }
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.to change(Scenery, :count).from(0).to(1)
      end
    end

    context 'when the quantity is wrong' do
      let(:first_team_spacecrafts) do
        first_team_spacecrafts_with_shape_one.concat(
          first_team_spacecrafts_with_shape_two
        )
      end

      let(:second_team_spacecrafts) do
        second_team_spacecrafts_with_shape_one.concat(
          second_team_spacecrafts_with_shape_two
        )
      end

      let!(:first_team_spacecrafts_with_shape_one) do
        (1..3).map { create(:spacecraft, team: team_one, shape: shape_one) }
      end

      let!(:first_team_spacecrafts_with_shape_two) do
        (1..2).map { create(:spacecraft, team: team_one, shape: shape_two) }
      end

      let!(:second_team_spacecrafts_with_shape_one) do
        (1..2).map { create(:spacecraft, team: team_two, shape: shape_one) }
      end

      let!(:second_team_spacecrafts_with_shape_two) do
        (1..2).map { create(:spacecraft, team: team_two, shape: shape_two) }
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.not_to change(Scenery, :count)
      end
    end

    context 'when just one team is present' do
      let(:first_team_spacecrafts) do
        (1..6).map { create(:spacecraft, team: team_one) }
      end

      let(:second_team_spacecrafts) { [] }

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.not_to change(Scenery, :count)
      end
    end
  end

  describe '#incompatible_shapes' do
    let(:background) { create(:scenery_background) }
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:shape_one) { create(:spacecraft_shape) }
    let(:shape_two) { create(:spacecraft_shape) }
    let(:spacecrafts) { first_team_spacecrafts.concat(second_team_spacecrafts) }

    let(:scenery_attributes) do
      attributes_for(:scenery, scenery_background_id: background.id,
                               spacecrafts: spacecrafts)
    end

    context 'when the shapes are corrent' do
      let(:first_team_spacecrafts) do
        first_team_spacecrafts_with_shape_one.concat(
          first_team_spacecrafts_with_shape_two
        )
      end

      let(:second_team_spacecrafts) do
        second_team_spacecrafts_with_shape_one.concat(
          second_team_spacecrafts_with_shape_two
        )
      end

      let!(:first_team_spacecrafts_with_shape_one) do
        (1..2).map { create(:spacecraft, team: team_one, shape: shape_one) }
      end

      let!(:first_team_spacecrafts_with_shape_two) do
        (1..2).map { create(:spacecraft, team: team_one, shape: shape_two) }
      end

      let!(:second_team_spacecrafts_with_shape_one) do
        (1..2).map { create(:spacecraft, team: team_two, shape: shape_one) }
      end

      let!(:second_team_spacecrafts_with_shape_two) do
        (1..2).map { create(:spacecraft, team: team_two, shape: shape_two) }
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.to change(Scenery, :count).from(0).to(1)
      end
    end

    context 'when the shapes are wrong' do
      let(:first_team_spacecrafts) do
        first_team_spacecrafts_with_shape_one.concat(
          first_team_spacecrafts_with_shape_two
        )
      end

      let(:second_team_spacecrafts) do
        second_team_spacecrafts_with_shape_one.concat(
          second_team_spacecrafts_with_shape_two
        )
      end

      let!(:first_team_spacecrafts_with_shape_one) do
        (1..2).map { create(:spacecraft, team: team_one, shape: shape_one) }
      end

      let!(:first_team_spacecrafts_with_shape_two) do
        (1..1).map { create(:spacecraft, team: team_one, shape: shape_two) }
      end

      let!(:second_team_spacecrafts_with_shape_one) do
        (1..1).map { create(:spacecraft, team: team_two, shape: shape_one) }
      end

      let!(:second_team_spacecrafts_with_shape_two) do
        (1..2).map { create(:spacecraft, team: team_two, shape: shape_two) }
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.not_to change(Scenery, :count)
      end
    end

    context 'when just one team is present' do
      let(:first_team_spacecrafts) do
        first_team_spacecrafts_with_shape_one.concat(
          first_team_spacecrafts_with_shape_two
        )
      end

      let(:second_team_spacecrafts) { [] }

      let!(:first_team_spacecrafts_with_shape_one) do
        (1..2).map { create(:spacecraft, team: team_one, shape: shape_one) }
      end

      let!(:first_team_spacecrafts_with_shape_two) do
        (1..1).map { create(:spacecraft, team: team_one, shape: shape_two) }
      end

      it do
        expect do
          Scenery.create(scenery_attributes)
        end.not_to change(Scenery, :count)
      end
    end
  end
end
