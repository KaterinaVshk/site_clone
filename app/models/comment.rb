class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :delete_all
end
