class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      cart_id = @user.cart.id
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user: @user, cart_id: cart_id }, status: :ok
    else
      render json: { error: @user.errors.full_messages.join(', ') }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end