module Matches
  class GameBoardDecorator < Draper::Decorator
    delegate :match, to: :object
    delegate :scenery, to: :match

    def background_url
      scenery.background.image.url(:large)
    end

    def spacecraft_positions
      SpacecraftPositionDecorator.decorate_collection(
        object.spacecraft_positions
      ).group_by(&:spacecraft_id)
    end
  end
end
