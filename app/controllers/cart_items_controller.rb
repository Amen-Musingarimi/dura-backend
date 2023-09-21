class CartItemsController < ApplicationController
    def create
      cart_item = CartItem.new(cart_item_params)
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
  
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :product_id, :quantity)
    end
  end