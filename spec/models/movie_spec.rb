require 'rails_helper'

RSpec.describe Movie, type: :model do

  # title
  it { is_expected.to validate_presence_of(:title) }
  # it { is_expected.to validate_uniqueness_of(:title) } # movies can have the same title

  # imdb_id
  it {is_expected.to validate_presence_of(:imdb_id)}
  it {is_expected.to validate_uniqueness_of(:imdb_id)}

  it { is_expected.to have_many(:reviews)}

  # validate format
  it "is not valid with an incorrect imdb_id" do
    movie = build(:movie)
    movie.update_attribute(:imdb_id, "badid04")
    puts movie.errors.full_messages
    expect(movie).to_not be_valid
  end
  it {is_expected.to validate_numericality_of(:imdb_rating).is_less_than(10).is_greater_than(0).allow_nil}
  it {is_expected.to validate_numericality_of(:runtime).is_greater_than(0).allow_nil}

  it "expects show_times to be an empty array for new movies" do
    movie = Movie.create(title: "The Dark Knight", imdb_id: "tt0468569/")
    expect(movie.show_times).to eq([])
  end

  it "updates correcly the attributes from the omdb database" do
    movie = build(:movie, imdb_id: "tt0232500", runtime: nil, release_date: nil, imdb_rating: nil)
    movie.update_from_omdb
    expect(movie.runtime).to eq(106)
    expect(movie.release_date.to_s).to eq("2001-06-22")
    expect(movie.imdb_rating).to eq(6.8)
  end

  it "shows the correct rating" do
    users = create_list(:user, 3)
    movie = build(:movie)
    sum = 0
    users.each do |user|
      rating = (1..9).to_a.sample
      sum += rating
      rev = create(:review, movie: movie, user: user, rating: rating)
    end
    expected_rating = (sum.to_f/3.0).round(2)
    expect(movie.rating).to eq(expected_rating)
  end
end
