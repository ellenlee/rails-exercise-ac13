class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :cart_id, :index => true
      t.integer :product_id
      t.integer :qty
      t.timestamps
    end
  end
end
