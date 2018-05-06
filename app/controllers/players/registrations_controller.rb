# frozen_string_literal: true

module Players
  class RegistrationsController < Devise::RegistrationsController
    before_action :load_player_avatares, only: %i[new create]
    before_action :configure_sign_up_params, only: [:create]

    def new
      super
    end

    def create
      super
    end

    protected

    def load_player_avatares
      @player_avatares = PlayerAvatar.all
    end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i[nickname player_avatar_id])
    end
  end
end
