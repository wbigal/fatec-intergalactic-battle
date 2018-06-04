class MatchesController < ApplicationController
  before_action :authenticate_player!

  def new
    @match = Match.new
    load_related_data
  end

  def create
    @match = build_match

    if @match.save
      redirect_to action: :awaiting_challenge, match_id: @match.id
    else
      load_related_data
      render :new
    end
  end

  def awaiting_challenge
    @match = Match.find_by(
      id: params[:match_id],
      player: current_player
    )

    redirect_to action: :new if @match.blank?
  end

  def join
    @match = Match.awaiting_challenge.find(params[:match_id])
    @match.join_challenger!(current_player)
    redirect_to :root
  end

  private

  def match_params
    params.require(:match).permit(:scenery_id, :player_team_id)
  end

  def load_related_data
    load_teams
    load_sceneries
  end

  def load_teams
    @teams = Team.all.order(:name)
  end

  def load_sceneries
    @sceneries = Scenery.all.order(:name)
  end

  def build_match
    match = Match.new(match_params)
    match.player = current_player
    match.challenger_team = selected_challenger_team
    match
  end

  def selected_challenger_team
    return nil if match_params[:player_team_id].blank?
    Team.where.not(id: match_params[:player_team_id]).first
  end
end
