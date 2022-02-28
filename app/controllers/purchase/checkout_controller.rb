class Purchase::CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    cart= @current_cart
    line_items_quantity= cart.line_items.count
    
    session = Stripe::Checkout::Session.create({
      customer: current_user.customer_stripe_id,
      line_items: [{
        price: Rails.application.credentials.stripe[:price],
        quantity: line_items_quantity,
      }],
  
      mode: 'payment',
      success_url: new_order_url,
      cancel_url: user_cart_url(user_id:current_user.id, id: @current_cart.id),
    })
    redirect_to session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  end
end
