Rails.application.routes.draw do

  resources :albums
  root to: 'welcome#index'

  resources :artists
  
end
