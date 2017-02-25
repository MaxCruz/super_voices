Rails.application.routes.draw do
    root "administrators#index"
    get "administrators", to: redirect("/")

    resources :voices
    resources :contests
    resources :administrators
end
