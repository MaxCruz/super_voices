Rails.application.routes.draw do
    root "administrators#index"
    get "/administrators", to: redirect("/")
    get "/administrator/login", to: "administrators#show_login", as: :login_form
    post "/administrator/login", to: "administrators#perform_login", as: :login_action

    resources :administrators

    resources :voices
    resources :contests
end
