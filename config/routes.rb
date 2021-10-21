Rails.application.routes.draw do
  root to:'address#index'
  resources :zip
end
