class V1::HomeController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback: :none

  def index
    render json: {a: user_signed_in?}.to_json
  end
end
