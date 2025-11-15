class OrdersController < ApplicationController
  before_action :set_cart, only: [:new, :create]
  before_action :ensure_cart_not_empty, only: [:new, :create]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @cart.line_items.each do |item|
        @order.order_items.create(product: item.product, price: item.product.price, quantity: item.quantity)
      end
      @order.calculate_total
      @order.save
      redirect_to order_path(@order), notice: 'Order placed successfully'
    else
      render :new, alert: 'Error placing order'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  
  def set_cart
    @cart = current_cart
  end

  def ensure_cart_not_empty
    redirect_to root_path, alert: 'Your cart is empty' if @cart.line_items.empty?
  end

  def order_params
    params.require(:order).permit(:name, :email, :address)
  end
end