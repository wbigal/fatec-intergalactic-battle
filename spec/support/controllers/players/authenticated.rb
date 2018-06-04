RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.before(:each, :player_authenticated) do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in(current_player)
  end

  def current_player
    @current_player ||= create(:player)
  end
end
