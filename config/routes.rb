Rails.application.routes.draw do
  resources :voices
  resources :contests
  resources :administrators
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
