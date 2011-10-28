Pong::Application.routes.draw do
  
  resources :matches
  resources :players
  
  root to: 'players#rankings'
end
