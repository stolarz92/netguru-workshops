Rails.application.routes.draw do
  resources :categories do
    resources :products do
      resources :reviews
    end
  end

  devise_for :users

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    get "profile", to: "users#show"
  end

  root 'categories#index'
end
