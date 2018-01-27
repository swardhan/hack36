Rails.application.routes.draw do

  get 'shops/nearest'
  get '/nearest', to: "shops#nearest"
  get '/closest_shop', to: "shops#closest_shop"

end
