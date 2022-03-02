class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  protect_from_forgery with: :exception
  
  before_action :current_cart
  before_action :configure_permitted_parameters, if: :devise_controller?


  
  private
  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  def current_cart
    if user_signed_in?
      if session[:cart_id]
        cart = Cart.find_by(:id => session[:cart_id])
        if cart.present?
          @current_cart = cart
        else
          session[:cart_id] = nil
        end
      end

      if session[:cart_id] == nil
        @current_cart = Cart.create(user_id: current_user.id)
        session[:cart_id] = @current_cart.id
      end
    end
  end

  def configure_permitted_parameters
    # Permit the `subscribe_newsletter` parameter along with the other
    # sign up parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
  end

end
