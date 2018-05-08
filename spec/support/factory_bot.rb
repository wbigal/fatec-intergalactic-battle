RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  sequence(:name) { |n| "#{Faker::Cat.name} #{n}" }
end
