Saasfinal::Application.routes.draw do
  resources :posts, :votes, :users, :tags, :comments

  root 'home#index'
  get '/session/oauth2', to: "session#oauth2_callback"
  get '/session/create', to: "session#create"
  get '/session/destroy', to: "session#destroy"
end
