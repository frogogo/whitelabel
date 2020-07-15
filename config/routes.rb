Rails.application.routes.draw do
  namespace :api do
    resource :user, only: %i[create update]
  end
end
