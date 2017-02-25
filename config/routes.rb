Rails.application.routes.draw do
    root "administrators#index"
    get "/administrators", to: redirect("/")

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"

    resources :administrators
    resources :voices
    resources :contests
end
