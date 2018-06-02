module Players
  class BaseController < ApplicationController
    before_action :authenticate_player!
  end
end
