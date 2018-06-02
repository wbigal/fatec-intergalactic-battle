# frozen_string_literal: true

module Players
  class RegistrationsController < Devise::RegistrationsController
    before_action :load_player_avatares, only: %i[new create edit update]
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_player_update_params, only: [:update]

    def new
      super
    end

    def create
      super
    end

    def edit
      super
    end

    def update
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

    def configure_player_update_params
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: %i[nickname player_avatar_id])
    end
  end
end
