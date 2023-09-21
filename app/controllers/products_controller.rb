class ProductsController < ApplicationController
  before_action :authenticate_request, only: [:create]

  # GET /products
  def index
    @products = Product.all.map do |product|
      product.attributes.merge(image: encode_image(product.image))
    end
    render json: @products
  end

  # POST /products
def create
  @product = Product.new(product_params)

  if @product.save
    # Associate the uploaded image with the product
    @product.image.attach(params[:product][:image])

    render json: @product, status: :created
  else
    render json: @product.errors, status: :unprocessable_entity
  end
end


  private

  def encode_image(image)
    if image.attached?
      {
        data: Base64.encode64(image.download),
        content_type: image.blob.content_type,
        filename: image.blob.filename.to_s
      }
    end
  end

  # Use strong parameters to allow only the parameters you expect
  def product_params
    params.require(:product).permit(:name, :english_name, :description, :price, :measurement_unit, :total_units, :image)
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