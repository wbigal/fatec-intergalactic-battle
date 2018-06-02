module Users
  class SessionsController < Devise::SessionsController
    layout 'users/sessions/sign_in'
  end
end
