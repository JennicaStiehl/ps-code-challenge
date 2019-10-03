Rails.application.routes.draw do
  get '/restaurants/:filter_by/:value', to: 'restaurants#index'
  # get '/restaurants/category/:category', to: 'restaurants#index', as: 'category'
end
