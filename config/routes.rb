Rails.application.routes.draw do
  get 'homes/index'
  root "homes#index"

  mount_devise_token_auth_for "User", at: "auth"
  namespace :api, format: "json" do
    namespace :v1 do
      resources :articles
    end
  end
end
