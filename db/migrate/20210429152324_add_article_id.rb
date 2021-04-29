class AddArticleId < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :article_id, :integer
  end
end
