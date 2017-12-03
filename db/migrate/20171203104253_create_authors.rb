class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :username
      t.string :device_id
      t.boolean :blocked

      t.timestamps
    end
  end
end
