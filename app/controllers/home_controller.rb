class HomeController < ApplicationController
  before_action :load_awaiting_challenge, only: %i[index]

  def index; end

  private

  def load_awaiting_challenge
    @awaiting_challenge = Home::AwaitingChallengeMatchDecorator.
                          decorate_collection(
                            Match.awaiting_challenge.
                                  includes(
                                    { player: :avatar }, :player_team, :scenery
                                  ).
                                  order(:created_at)
                          )
  end
end
