require 'rails_helper'

RSpec.describe "Movies" do
  it "shows the movie correctly" do
    movie = create(:movie)
    get "/v1/movies/#{movie.imdb_id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include(movie.to_json)
  end
end
