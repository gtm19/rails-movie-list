class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates :movie, uniqueness: { scope: :list, message: "already added to this list. Try another." }
  validates :comment, length: { minimum: 6 }
end
