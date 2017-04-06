class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :payment_method
      t.string :shipping_method

      t.integer :user_id, :index => true

      t.integer :amount
      
      t.timestamps
    end
  end
end
