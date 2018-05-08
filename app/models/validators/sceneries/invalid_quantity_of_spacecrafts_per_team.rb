module Validators
  module Sceneries
    class InvalidQuantityOfSpacecraftsPerTeam < ActiveModel::Validator
      def validate(record)
        team_group = record.spacecrafts.group_by do |spacecraft|
          spacecraft.team.id
        end

        return if valid?(team_group)

        record.errors.add(:spacecrafts,
                          :invalid_quantity_of_spacecrafts_per_team)
      end

      private

      def valid?(team_group)
        team_group.values.first&.size == team_group.values.second&.size
      end
    end
  end
end
