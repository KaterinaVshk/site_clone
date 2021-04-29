class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type
      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
