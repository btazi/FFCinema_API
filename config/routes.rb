Rails.application.routes.draw do
  devise_for :users
  
  namespace :v1 do
    post "sessions", as: "create_session", to: "sessions#create"
    delete "sessions", as: "delete_session", to: "sessions#destroy"
    resources :home, only: [:index]
  end
end
