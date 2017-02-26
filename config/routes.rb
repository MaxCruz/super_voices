Rails.application.routes.draw do
    root "administrators#index"
    get "/administrators", to: redirect("/")

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"

    get "/sites/:key", to: "sites#index"
    get "/sites/:key/new", to: "sites#new"
    post "/sites/:key", to: "sites#create", as: :site_create

    resources :administrators
    resources :voices
    resources :contests
end
