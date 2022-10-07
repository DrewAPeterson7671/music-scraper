Rails.application.routes.draw do

  root to: 'welcomes#index'

  resources :annual_ranks
  devise_for :users

  resource :welcome, only: [:new, :update]
  
  resources :artists do
    resources :albums
  end

  resources :albums do
  end
  
end
