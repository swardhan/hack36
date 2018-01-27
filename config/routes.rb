Rails.application.routes.draw do
  get 'shops/nearest'

  get '/nearest', to: "shops#nearest" 
end
