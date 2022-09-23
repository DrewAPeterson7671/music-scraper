Rails.application.routes.draw do

  resources :annual_ranks
  devise_for :users
  root to: 'welcomes#index'

  resource :welcome, only: [:new, :update]
  
  resources :artists do
    resources :albums
  end

  resources :albums do
  end
  
end
