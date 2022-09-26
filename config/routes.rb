Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "static_pages/help"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :reports, except: %i(index destroy)
    resources :departments do
      resources :user_departments, except: :create
      post "add_user", to: "user_departments#create", as: "add_user_to_department"
    end
  end
end
