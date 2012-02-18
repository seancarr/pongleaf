Pong::Application.routes.draw do
  
  resources :matches
  resources :players
  
  match '/distribution' => 'players#distribution', :as => 'distribution'
  
  root to: 'players#rankings'
end
