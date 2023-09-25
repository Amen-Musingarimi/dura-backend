class CartItemsController < ApplicationController
  before_action :authenticate_request, only: [:create]

  def index
    cart_items = CartItem.where(cart_id: params[:cart_id])
    render json: cart_items, include: :product
  end

  def create
    user_id = JsonWebToken.decode(request.headers['Authorization'].split(' ')[1])['user_id']
    cart_id = User.find(user_id).cart.id
    cart_item = CartItem.new(cart_item_params.merge(cart_id: cart_id))
    if cart_item.save
      render json: cart_item
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
    def update
      cart_item = CartItem.find(params[:id])
      if cart_item.update(cart_item_params)
        render json: cart_item
      else
        render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      cart_item = CartItem.find(params[:id])
      cart_item.destroy
      head :no_content
    end
  
    private

    def authenticate_request
      token = request.headers['Authorization'].split(' ')[1]
      unless token && JsonWebToken.decode(token)
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    rescue JWT::DecodeError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :product_id, :quantity)
    end
  end