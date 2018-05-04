Rails.application.routes.draw do
  root 'home#index'
  resources :transfers, only: %i[new create]
end
