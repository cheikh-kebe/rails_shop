class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_line_item, only: %i[ add_quantity reduce_quantity show destroy ]
  def add_quantity
    @line_item.quantity += 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end
  
  def reduce_quantity
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # POST /line_items or /line_items.json
  def create
    chosen_product = Item.find(params[:item_id])
    current_cart = @current_cart
    if current_cart.items.include?(chosen_product)
      # Find the line_item with the chosen_product
      @line_item = current_cart.line_items.find_by(:item_id => chosen_product)
      # Iterate the line_item's quantity by one
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.item = chosen_product
    end

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to items_path, notice: "Item ajouté au panier." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    current_cart = @current_cart
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_path(current_cart), notice: "item supprimé du panier." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.fetch(:line_item, {})
    end
end
