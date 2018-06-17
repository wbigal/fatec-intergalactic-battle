module Matches
  class SpacecraftPositionDecorator < Draper::Decorator
    delegate :spacecraft_id, to: :object
    delegate :row, to: :object
    delegate :column, to: :object

    def image_url
      object.spacecraft.image.url
    end
  end
end
