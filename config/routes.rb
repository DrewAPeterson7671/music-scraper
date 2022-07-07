Rails.application.routes.draw do

  devise_for :users
  root to: 'welcomes#index'

  resource :welcome, only: [:new, :update]
  
  resources :artists do
    resources :albums
  end
  
end
