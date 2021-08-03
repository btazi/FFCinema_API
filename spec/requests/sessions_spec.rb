require 'rails_helper'

RSpec.describe "Sessions" do
  it "signs user in and out correctly" do
    user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password") # use factorybot later
    post "/v1/sessions", params: {email: "test@test.com", password: "password"}
    json = JSON.parse(response.body)
    token = json["auth_token"]

    expect(token.length).to eq(20)
    expect(json.keys).to eq(%w(success auth_token email id))
    expect(response).to have_http_status(201)

    delete "/v1/sessions", headers: {"X-User-Email" => "test@test.com", "X-User-Token" => token}
    expect(response).to have_http_status(200)

    # It should not be possible to sign out twice (the authentication token is deleted correctly)
    delete "/v1/sessions", headers: {"X-User-Email" => "test@test.com", "X-User-Token" => token}
    expect(response).to have_http_status(401)
    message = JSON.parse(response.body)["message"]
    expect(message).to eq("You are already signed out")

    # A new token must be created when signed in again
    post "/v1/sessions", params: {email: "test@test.com", password: "password"}
    json = JSON.parse(response.body)
    new_token = json["auth_token"]
    expect(new_token).not_to eq(token)
  end

  it "does not sign in with bad credentials" do
    user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password") # use factorybot later
    post "/v1/sessions", params: {email: "test@test.com", password: "bad password"}
    json = JSON.parse(response.body)
    token = json["auth_token"]

    expect(token).to be_nil
    expect(response).to have_http_status(401)
  end

end
