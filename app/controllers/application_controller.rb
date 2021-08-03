class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  private
  
  def authorize_admins
    unless user_signed_in? && current_user.role == "admin"
      render json: { success: false, message: "You must be an admin" }, status: :unauthorized
      return
    end
  end
end
