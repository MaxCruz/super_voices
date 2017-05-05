Rails.application.routes.draw do

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"

    get "/sites/:key", to: "sites#index"
    get "/sites/:key/new", to: "sites#new"
    post "/sites/:key", to: "sites#create", as: :site_create
    post "/sites/:key/publish", to: "sites#publish", as: :site_publish

    get "/hirefire/#{ENV["HIREFIRE_TOKEN"]}/info", to: "session#queue"

    root "administrators#index"
    get "/administrators", to: redirect("/")
    resources :administrators

    resources :contests

end
