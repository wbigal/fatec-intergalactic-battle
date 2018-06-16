module Matches
  module GameBoards
    class SpacecraftPositionsController < BaseController
      #before_action -> { redirect_to(:root) unless request.xhr? }

      def new
        @spacecraft_form = Matches::GameBoards::SpacecraftForm.new
        load_form_data
        render :new
      end

      def create
        @spacecraft_form = Matches::GameBoards::SpacecraftForm.new(
          spacecraft_params
        )
      
        if @spacecraft_form.valid?
          create_spacecraft_positions
          render :create, status: :created
          #render json: { success: true }
        else
          load_form_data
          render :create, status: :unprocessable_entity
        end
      end

      private

      def create_spacecraft_positions
        ::GameBoards::SpacecraftPositions::Create.call(
          game_board: @game_board,
          spacecraft: Spacecraft.find(@spacecraft_form.spacecraft_id),
          row: @spacecraft_form.row.to_i,
          column: @spacecraft_form.column.to_i
        )
        load_form_data
      end

      def game_board_id
        params[:game_board_id]
      end

      def spacecraft_params
        params.require(:matches_game_boards_spacecraft_form).permit(
          :spacecraft_id, :row, :column
        )
      end

      def spacecraft_positions
        ::GameBoards::SpacecraftPosition.includes(:spacecraft).where(
          game_board_id: params[:game_board_id]
        )
      end

      def load_form_data
        load_spacecrafts
        load_spacecraft_positions
      end

      def load_spacecrafts
        @spacecrafts = @game_board.match.scenery.spacecrafts.where.not(
          id: spacecraft_positions.select(:spacecraft_id)
        )
      end

      def load_spacecraft_positions
        @spacecraft_positions = spacecraft_positions.group_by(&:spacecraft_id)

        space = []
        geralPos = []
        images = []

        @spacecraft_positions.each_pair do |spacecraft_id, positions|
          space.push(spacecraft_id)
          geralPos.push(positions.pluck(:row, :column).first)
          images.push(positions.first.spacecraft.image.url)
        end

        gon.spacecraft = space
        gon.positions = geralPos
        gon.url = images

        puts '-------------'
        puts space

        @spacecraft = space
        @positions = geralPos
        @url = images
      end
    end
  end
end
