class ProductsController < ApplicationController
  before_action :authenticate_request, only: [:create]

  # GET /products
  def index
    @products = Product.all
    render json: @products
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def product_params
    params.require(:product).permit(:name, :english_name, :description, :price, :measurement_unit, :total_units, :image_url)
  end

  def authenticate_request
    token = request.headers['Authorization'].split(' ')[1]
    unless token && JsonWebToken.decode(token)
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
