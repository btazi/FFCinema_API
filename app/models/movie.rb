class Movie < ApplicationRecord

  has_many :reviews

  validates_presence_of :title, :imdb_id
  validates_format_of :imdb_id, :with => /\Att\d{7}\Z/
  validates_uniqueness_of :imdb_id
  validates :imdb_rating, numericality: { greater_than: 0, less_than: 10, allow_nil: true }
  validates :runtime, numericality: { greater_than: 0 }, allow_nil: true


  def update_from_omdb
    omdb_key = Rails.application.credentials.omdb_key
    url = "http://www.omdbapi.com/?i=#{imdb_id}&apikey=#{omdb_key}"
    request = RestClient.get(url)
    json = JSON.parse(request.body).slice("Runtime", "Released", "imdbRating")
    runtime = json.dig("Runtime")&.gsub(/\D/, '')
    assign_attributes(runtime: runtime, release_date: json["Released"], imdb_rating: json["imdbRating"])
    save
  end

  def rating
    reviews.any? ? (reviews.sum(:rating).to_f/reviews.count.to_f).round(2) : nil
  end
end
