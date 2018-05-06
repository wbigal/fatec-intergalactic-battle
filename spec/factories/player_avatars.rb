FactoryBot.define do
  factory :player_avatar do
    name  'Luke Skywalker'
    image_file_name 'luke-skywalker.jpg'
    image_content_type 'image/jpeg'
    image_file_size 2
    image_updated_at Time.new(2015, 8, 18).utc
  end
end
