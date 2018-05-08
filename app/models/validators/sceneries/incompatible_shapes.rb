module Validators
  module Sceneries
    class IncompatibleShapes < ActiveModel::Validator
      def validate(record)
        team_group = team_group(record)
        return if team_group.size != 2
        record.errors.add(:spacecrafts, :incompatible_shapes) \
        unless valid?(team_group)
      end

      private

      def valid?(team_group)
        total_first_shape = total_first_shape(team_group)
        total_second_shape = total_second_shape(team_group)
        (total_first_shape & total_second_shape).present?
      end

      def team_group(record)
        record.spacecrafts.group_by do |spacecraft|
          spacecraft.team.id
        end
      end

      def first_shape_group(team_group)
        team_group.values.first&.group_by do |spacecraft|
          spacecraft.shape.id
        end
      end

      def second_shape_group(team_group)
        team_group.values.second&.group_by do |spacecraft|
          spacecraft.shape.id
        end
      end

      def total_first_shape(team_group)
        first_shape_group(team_group).map do |shape_id, spacecrafts|
          [shape_id, spacecrafts.size]
        end
      end

      def total_second_shape(team_group)
        second_shape_group(team_group).map do |shape_id, spacecrafts|
          [shape_id, spacecrafts.size]
        end
      end
    end
  end
end
