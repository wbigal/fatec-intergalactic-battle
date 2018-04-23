class Scenery < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  validates :rows, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 10
  }

  validates :columns, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 10
  }

  has_attached_file :image,
                    styles: {
                      thumb: '112x',
                      large: '1920x'
                    },
                    convert_options: {
                      all: '-strip -quality 80 -interlace Plane'
                    }
  validates_attachment :image,
                       content_type: { content_type: %w[image/jpeg image/jpg] },
                       size: { less_than: 2.megabyte }
end
