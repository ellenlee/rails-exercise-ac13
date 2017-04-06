class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_order.subject
  #

  def notify_order(order)
    @order = order
    mail :subject => "新訂單: #{order.id}",
         :to => order.user.email
  end

end
