class Admin < User
  has_many :articles, dependent: :delete_all
end
