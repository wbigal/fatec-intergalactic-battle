module Matches
  module GameBoards
    class DropBombForm
      include ActiveModel::Model

      attr_accessor :row
      attr_accessor :column

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
