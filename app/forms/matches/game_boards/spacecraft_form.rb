module Matches
  module GameBoards
    class SpacecraftForm
      include ActiveModel::Model

      attr_accessor :spacecraft_id
      attr_accessor :row
      attr_accessor :column

      validates :spacecraft_id, presence: true, numericality: {
        only_integer: true
      }

      validates :row, presence: true, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0
      }

      validates :column, presence: true, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0
      }
    end
  end
end
