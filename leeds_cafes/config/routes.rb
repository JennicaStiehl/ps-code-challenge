Rails.application.routes.draw do
  get '/restaurants/:filter_by/:value', to: 'restaurants#index'
  get '/post_codes', to: 'post_codes#index'
  get '/category', to: 'categories#index'
end
