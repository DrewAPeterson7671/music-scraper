Rails.application.routes.draw do

  root to: 'welcomes#index'

  resources :annual_ranks

  # need to research
  # map.resources :annual_ranks, :collection => { :alt_collection => :put }

  match 'annual_ranks/all/edit' => 'annual_ranks#edit_all', :as => :edit_all, :via => :get
  match 'annual_ranks/all' => 'annual_ranks#update_all', :as => :update_all, :via => :put 

  devise_for :users

  resource :welcome, only: [:new, :update]
  
  resources :artists do
    resources :albums
  end

  resources :albums do
  end
 
end
