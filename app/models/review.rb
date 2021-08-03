class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_presence_of :user, :movie, :rating
  validates_uniqueness_of :user, scope: :movie

  validates_numericality_of :rating, greater_than: 0, less_than: 10
end
