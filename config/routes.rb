Pong::Application.routes.draw do
  
  resources :matches do
    collection do
      get 'rankings'
      get 'players'
    end
  end
  
  match 'rankings' => 'matches#rankings'
  match 'matches/:player_id' => 'matches#index'
  
  root to: 'matches#new'
end
