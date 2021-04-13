class Article < ApplicationRecord
  CATEGORY_MAP = { people: 1, opinions: 2, auto: 3, technologies: 4, realt: 5 }.freeze
  has_one_attached :image
  validates :title, presence: true
  validates :image, presence: true
  belongs_to :category
end
