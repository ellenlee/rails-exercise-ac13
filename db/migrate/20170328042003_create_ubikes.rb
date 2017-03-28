class CreateUbikes < ActiveRecord::Migration[5.0]
  def change
    create_table :ubikes do |t|
      t.string :name
      t.string :raw_id

      t.timestamps
    end
  end
end
