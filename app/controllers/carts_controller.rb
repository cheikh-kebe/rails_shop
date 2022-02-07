class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show destroy ]
  before_action :authenticate_user!
  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Panier supprimé!." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = @current_cart
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end
end
