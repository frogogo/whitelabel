Rails.application.routes.draw do
  namespace :api do
    resources :home, only: %i[index]
    resources :receipts, only: %i[index create]
    resource :user, only: %i[create show update]
    resources :user_token, only: %i[create]
    resources :items, only: %i[index show]
  end

  namespace :apm do
    resources :callback, only: %i[create]
  end
end
