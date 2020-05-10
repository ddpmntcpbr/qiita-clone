Rails.application.routes.draw do
  root "homes#index"

  mount_devise_token_auth_for "User", at: "api/v1/auth", controllers: {
    registrations: 'api/v1/auth/registrations'
  }

  namespace :api, format: "json" do
    namespace :v1 do
      resources :articles
    end
  end
end
