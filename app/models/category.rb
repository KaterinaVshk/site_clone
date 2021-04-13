class Category < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  has_many :articles, dependent: :delete_all
end
