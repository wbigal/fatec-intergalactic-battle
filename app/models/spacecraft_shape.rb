# == Schema Information
#
# Table name: spacecraft_shapes
#
#  id                    :bigint(8)        not null, primary key
#  name                  :string(50)       not null
#  template_file_name    :string
#  template_content_type :string
#  template_file_size    :integer
#  template_updated_at   :datetime
#  targets               :json             not null
#  spacecraft_width      :integer          not null
#  spacecraft_height     :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class SpacecraftShape < ApplicationRecord
  has_many :spacecrafts, dependent: :restrict_with_error

  validates :name, presence: true, length: { maximum: 50 }
  validates :targets, presence: true

  validates :spacecraft_width, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 50,
    less_than_or_equal_to: 320
  }

  validates :spacecraft_height, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 50,
    less_than_or_equal_to: 302
  }

  has_attached_file :template,
                    styles: {
                      large: '320x302#'
                    },
                    convert_options: {
                      all: '-strip -quality 80 -interlace Plane'
                    }
  validates_attachment :template,
                       presence: true,
                       content_type: { content_type: %w[image/png] },
                       size: { less_than: 2.megabyte }
end
