class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :set_current_cart, only: %i[ new create ]
  before_action :authenticate_user!
  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @user = current_user
    @user_id = current_user.id
    @stripe_amount = @cart.sub_total
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @user = current_user
    @amount = @cart.sub_total
    @stripe_amount = (@amount.to_f * 100).to_i
    @cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @stripe_amount,
        description: "Achat d'un produit",
        currency: "eur",
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_path
    end
    @customer_stripe_id = customer.id
    respond_to do |format|
      @order.update(customer_stripe_id: @customer_stripe_id, username: @user.username, adress: @user.adress, name: @user.first_name, email: @user.email)
      if @order.save
        @cart.destroy
        format.html { redirect_to root_path, notice: "Votre commande a bien été validée, vous allez recevoir un mail tout bientôt !" }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def set_current_cart
    @cart = @current_cart
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.permit(:user_id, :cart_id, :total_price)
  end
end
