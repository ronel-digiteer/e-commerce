module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: [:edit, :update, :destroy]

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: 'Product created successfully'
      else
        render :new, alert: 'Error creating product'
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: 'Product updated successfully'
      else
        render :edit, alert: 'Error updating product'
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path, notice: 'Product deleted successfully'
    end

    private

    def set_product
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_products_path, alert: 'Product not found'
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image_url, :category_id)
    end
  end
end