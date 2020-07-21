Rails.application.routes.draw do
  namespace :api do
    resource :user, only: %i[create show update]
    post 'user_token' => 'user_token#create'
  end
end
