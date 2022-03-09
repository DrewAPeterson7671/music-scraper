Rails.application.routes.draw do
  resources :artists

  root to: 'welcome#index'
  
end
