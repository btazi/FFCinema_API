class V1::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find_by(imdb_id: params[:imdb_id])
    if @movie
      review = Review.find_or_initialize_by(movie_id: @movie.id, user_id: current_user.id)
      review.rating = params[:rating]
      if review.save
        render json: {success: true, review: review}, status: 200
      else
        render json: {success: false, message: "could not #{review.persisted? ? 'update' : 'create'} this review"}, status: 400
      end
    else
        render json: {success: false, message: "something went wrong, could not create or update this review"}, status: 400
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:rating)
  end

end
