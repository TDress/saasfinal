Saasfinal::Application.routes.draw do
  resources :posts, :users
  root 'home#index'
end
