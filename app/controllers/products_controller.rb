class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # ... Implement update and destroy actions ...

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :english_name, :description, :price, :measurement_unit, :total_units, :image)
  end
end
