class V1::SessionsController < ApplicationController
  def create
    resource = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      render json: { success: true, auth_token: resource.authentication_token, email: resource.email, id: resource.id }, status: :created
      return
    end
    invalid_login_attempt
  end

  def destroy
    if user_signed_in?
      current_user.update_attribute(:authentication_token, nil)
      signed_out = sign_out(current_user)
      render json: {success: 200}, status: 200 if signed_out
      return
    else
      message = if user_signed_in?
                  "Could not sign out"
                else
                  "You are already signed out"
                end
      render json: {success: false, message: message }, status: :unauthorized
      return
    end
  end

  protected

  def invalid_login_attempt
    render json: { success: false, message: "Error with your login or password"}, status: :unauthorized
  end

end
