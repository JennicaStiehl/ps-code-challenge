Rails.application.routes.draw do
  get '/restaurants/:filter_by/:value', to: 'restaurants#index'
end
