class Pay2goController < ApplicationController

  skip_before_action :verify_authenticity_token

  def return
    @payment = Payment.find_and_process( json_data )

    unless @payment.save
      flash[:alert] = "不要HACK我啦~~~"
    end

    @order = @payment.order

    if @payment.paid_at
     # send paid email
    end

    redirect_to order_path(@order)
  end

  def notify
    @payment = Payment.find_and_process( json_data )
    
    if @payment.save
      render :text => "1|OK"
    else
      render :text => "0|ErrorMessage"
    end

  end

  private

  def json_data
    JSON.parse( params["JSONData"] )
  end

end
