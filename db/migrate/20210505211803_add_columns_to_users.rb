class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :birthday, :date
    add_column :users, :city, :string
    add_index :users, :nickname, unique: true
  end
end
