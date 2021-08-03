class V1::MoviesController < ApplicationController
  before_action :get_movie_by_imdb_id, only: [:show, :update]
  before_action :authorize_admins, only: [:update]

  def index
    @movies = Movie.all
    render json: {success: true, movies: @movies.map{|movie| {movie: movie.title, imdb_id: movie.imdb_id, show_times: movie.show_times}}}
  end

  def show
    if @movie
      @movie.update_from_omdb
      render json: {success: true, movie: @movie}, status: 200
    elsif @movie.nil?
      render json: {success: false, error: "Could not find movie with id #{params[:id]}"}, status: 404
    end
  end

  def update
    show_times = movie_params.dig("show_times")
    show_times = JSON.parse(show_times).map{|time| Time.parse(time)}
    price = movie_params.dig("price_in_usd")
    if show_times && price && @movie.update(show_times: show_times, price_in_usd: price)
      render json: { success: true, movie: @movie }, status: :created
    else
      render json: { success: false, movie: @movie }, status: 400
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:show_times, :price_in_usd)
  end

  def get_movie_by_imdb_id
    @movie = Movie.find_by(imdb_id: params[:id])
  end
end
