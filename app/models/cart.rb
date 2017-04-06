class Cart < ApplicationRecord

  has_many :cart_items

  def add_product(product)
    existing_item = self.cart_items.find_by_product_id( product.id )
    if existing_item
      existing_item.qty += 1
      existing_item.save!
    else
      item = self.cart_items.build( :product_id => product.id, :qty => 1 )
      item.save!
    end
  end

end
