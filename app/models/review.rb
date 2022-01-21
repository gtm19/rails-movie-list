class Review < ApplicationRecord
  belongs_to :list
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :comment, length: { minimum: 6 }
end
