# == Schema Information
#
# Table name: spacecrafts
#
#  id                  :bigint(8)        not null, primary key
#  team_id             :bigint(8)        not null
#  spacecraft_shape_id :bigint(8)        not null
#  name                :string(50)       not null
#  image_file_name     :string
#  image_content_type  :string
#  image_file_size     :integer
#  image_updated_at    :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Spacecraft < ApplicationRecord
  belongs_to :team
  belongs_to :shape, class_name: 'SpacecraftShape',
                     foreign_key: 'spacecraft_shape_id',
                     inverse_of: 'spacecrafts'

  has_and_belongs_to_many :sceneries

  has_many :spacecraft_positions, class_name: 'GameBoards::SpacecraftPosition',
                                  dependent: :restrict_with_error

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }

  has_attached_file :image,
                    convert_options: {
                      all: '-strip -quality 80 -interlace Plane'
                    }
  validates_attachment :image,
                       presence: true,
                       content_type: { content_type: %w[image/png] },
                       size: { less_than: 2.megabyte }

  def full_description
    return name if team.blank? || shape.blank?
    "#{team.name} | #{name} - "\
    "#{shape.spacecraft_width}x#{shape.spacecraft_height}px"
  end
end
