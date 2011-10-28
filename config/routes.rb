Pong::Application.routes.draw do
  match 'rankings' => 'matches#rankings'
  match 'matches' => 'matches#matches'
  
  resources :matches do
    collection do
      get 'rankings'
      get 'players'
    end
  end
  
  root to: 'matches#index'
end
