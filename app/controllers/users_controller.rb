class UsersController < ApplicationController
  skip_before_action :authorized, only: [:sign_up, :sign_in]

  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { message: @user.errors.full_messages[0] }, status: :bad_request
    end
  end

  def sign_in
    @user = User.find_by(email_id: user_params[:email_id])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({ user_id: @user.id })
      response = { user: @user, token: token, avatar: nil }
      response[:avatar] = rails_blob_url(@user.avatar) if @user&.avatar&.attached?
      render json: response
    else
      render json: { message: 'Incorrect email or password!' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email_id, :password, :avatar)
  end
end