Rails.application.routes.draw do
  devise_for :users
  
  namespace :v1 do
    post "sessions", as: "create_session", to: "sessions#create"
    delete "sessions", as: "delete_session", to: "sessions#destroy"
    resources :movies, only: [:index, :show, :update]
    post "reviews/:imdb_id", as: "create_review", to: "reviews#create"
  end
end
