class AddAdminForArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :admin, index: true
  end
end
