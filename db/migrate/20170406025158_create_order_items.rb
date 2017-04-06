class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id, :index => true
      t.integer :product_id
      t.integer :price
      t.integer :qty
      t.timestamps
    end
  end
end
