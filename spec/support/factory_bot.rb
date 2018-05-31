RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  sequence(:name) { |n| "#{Faker::Cat.name} #{n}" }
end

FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }
end

FactoryBot.define do
  sequence(:nickname) { |n| "#{Faker::Cat.name}#{n}" }
end
