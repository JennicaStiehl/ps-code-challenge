Rails.application.routes.draw do
  # resources :restaurants, only: [:index]
  get '/restaurants/:post_code', to: 'restaurants#index', as: 'cafes'
end
