class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|
      t.integer :comment_id
      t.integer :user_id
      t.string :type

      t.timestamps
    end
    add_index :preferences, [:user_id, :comment_id]
  end
end
