class Order < ApplicationRecord

  validates_presence_of :name

  belongs_to :user

  has_many :order_items

  has_many :payments

  def paid?
    self.status == "paid"
  end

  def add_items(cart)
    cart.cart_items.each do |item|
      self.order_items.build( :product_id => item.product_id,
                              :qty => item.qty,
                              :price => item.product.price )
    end

    self.amount = self.order_items.map{ |i| i.qty * i.price }.sum
  end

end
