module Matches
  class DroppedBombDecorator < Draper::Decorator
    delegate :row, to: :object
    delegate :column, to: :object
    delegate :on_target?, to: :object
  end
end
