FactoryBot.define do
  factory :scenery do
    name  'Scenery'
    rows 10
    columns 10
    image_file_name 'just-a-pic.jpg'
    image_content_type 'image/jpeg'
    image_file_size 2
    image_updated_at Time.new(2015, 8, 18).utc
  end
end
