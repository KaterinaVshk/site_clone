class AddColumnToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :likes_count, :integer , default: 0
    add_column :comments, :dislikes_count, :integer, default: 0
  end
end
