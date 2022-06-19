Rails.application.routes.draw do

  root to: 'welcome#index'
  
  resources :artists do
    resources :albums
  end
  
end
