module LocalizableTarget
  extend ActiveSupport::Concern

  included do
    validate :row_out_of_range
    validate :column_out_of_range
    validates :row, presence: true, numericality: { only_integer: true }
    validates :column, presence: true, numericality: { only_integer: true }

    private

    def row_out_of_range
      return if scenery.blank?
      errors.add(:row, :row_out_of_range) \
      if row.negative? || row >= scenery.rows
    end

    def column_out_of_range
      return if scenery.blank?
      errors.add(:column, :column_out_of_range) \
      if column.negative? || column >= scenery.columns
    end
  end
end
