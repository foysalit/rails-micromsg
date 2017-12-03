class AddIndexToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_index :authors, :username, unique: true
  end
end
