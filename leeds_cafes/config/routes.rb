Rails.application.routes.draw do
  get '/restaurants/:post_code', to: 'restaurants#index', as: 'cafes'
end
