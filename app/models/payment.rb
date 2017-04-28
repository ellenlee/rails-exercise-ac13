class Payment < ApplicationRecord

  PAYMENT_METHODS = %w[Credit WebATM ATM CVS BARCODE]
  validates_inclusion_of :payment_method, :in => PAYMENT_METHODS

  serialize :params, JSON

  belongs_to :order

  validate :check_mac, on: :update

  after_update :update_order_status

  def self.find_and_process(params)
    result = JSON.parse( params['Result'] )

    payment = self.find(result['MerchantOrderNo'].to_i)

    if params['Status'] == 'SUCCESS'
      payment.paid_at = Time.now
    end

    payment.params = params

    payment
  end

  def email
    self.order.user.email
  end

  def external_id
    "#{self.id}AC13#{Rails.env.upcase[0]}"
  end

  def name
    "AC商店訂單編號 #{self.order_id}"
  end

  def deadline
    Date.today + 3.days
  end

  def check_mac
     pay2go = Pay2go.new(parse_result)
     errors.add(:params, 'wrong mac value') unless pay2go.check_mac
  end

  def parse_result
    JSON.parse( self.params['Result'] )
  end

  def update_order_status
    if self.paid_at
      self.order.update( :status => "paid" )
    end
  end
end
