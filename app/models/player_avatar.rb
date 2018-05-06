# == Schema Information
#
# Table name: player_avatars
#
#  id                 :bigint(8)        not null, primary key
#  name               :string(50)       not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class PlayerAvatar < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  has_attached_file :image,
                    styles: {
                      thumb: '80x60#',
                      large: '110x83#'
                    },
                    convert_options: {
                      all: '-strip -quality 80 -interlace Plane'
                    }
  validates_attachment :image,
                       content_type: {
                         content_type: %w[
                           image/jpeg image/jpg image/gif image/png
                         ]
                       },
                       size: { less_than: 2.megabyte }
end
