class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = if params[:search]
                  Product.search(params[:search])
                else
                  Product.all
                end
  end
  
  def show
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Product not found'
  end
end