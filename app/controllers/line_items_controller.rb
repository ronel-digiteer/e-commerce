class LineItemsController < ApplicationController
  before_action :set_cart
  before_action :set_line_item, only: [:update, :destroy]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.line_items.build(product: product, quantity: line_item_params[:quantity])

    if @line_item.save
      redirect_to cart_path, notice: 'Product added to cart'
    else
      redirect_to product, alert: 'Unable to add product'
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to cart_path, notice: 'Item updated'
    else
      redirect_to cart_path, alert: 'Unable to update item'
    end
  end

  def destroy
    @line_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart'
  end

  private

  def set_cart
    @cart = current_cart
  end

  def set_line_item
    @line_item = @cart.line_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path, alert: 'Item not found'
  end

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end