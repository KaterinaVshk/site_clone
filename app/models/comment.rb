class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :delete_all
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  def liked?(comment_id, user_id)
    preference = Preference.find_by(comment_id: comment_id, user_id: user_id)
    preference&.is_a?(Like)
  end
end
