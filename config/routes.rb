# == Route Map
#
#                          Prefix Verb  URI Pattern                                                                                       Controller#Action
#                         trestle       /admin                                                                                            Trestle::Engine
#                            root GET   /                                                                                                 application#index
#                          retail GET   /retail(.:format)                                                                                 application#retail
#                            fmcg GET   /fmcg(.:format)                                                                                   application#fmcg
#                  api_home_index GET   /api/home(.:format)                                                                               api/home#index
#                    api_receipts GET   /api/receipts(.:format)                                                                           api/receipts#index
#                                 POST  /api/receipts(.:format)                                                                           api/receipts#create
#                        api_user GET   /api/user(.:format)                                                                               api/users#show
#                                 PATCH /api/user(.:format)                                                                               api/users#update
#                                 PUT   /api/user(.:format)                                                                               api/users#update
#                                 POST  /api/user(.:format)                                                                               api/users#create
#            api_user_token_index POST  /api/user_token(.:format)                                                                         api/user_token#create
#              apm_callback_index POST  /apm/callback(.:format)                                                                           apm/callback#create
#              rails_service_blob GET   /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#        rails_service_blob_proxy GET   /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                 GET   /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#       rails_blob_representation GET   /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
# rails_blob_representation_proxy GET   /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                 GET   /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#              rails_disk_service GET   /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#       update_rails_disk_service PUT   /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#            rails_direct_uploads POST  /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
#
# Routes for Trestle::Engine:
#                           login GET    /login(.:format)                        trestle/auth/sessions#new
#                                 POST   /login(.:format)                        trestle/auth/sessions#create
#                          logout GET    /logout(.:format)                       trestle/auth/sessions#destroy
# auth_administrators_admin_index GET    /auth/administrators(.:format)          auth/administrators_admin/admin#index
#                                 POST   /auth/administrators(.:format)          auth/administrators_admin/admin#create
#   new_auth_administrators_admin GET    /auth/administrators/new(.:format)      auth/administrators_admin/admin#new
#  edit_auth_administrators_admin GET    /auth/administrators/:id/edit(.:format) auth/administrators_admin/admin#edit
#       auth_administrators_admin GET    /auth/administrators/:id(.:format)      auth/administrators_admin/admin#show
#                                 PATCH  /auth/administrators/:id(.:format)      auth/administrators_admin/admin#update
#                                 PUT    /auth/administrators/:id(.:format)      auth/administrators_admin/admin#update
#                                 DELETE /auth/administrators/:id(.:format)      auth/administrators_admin/admin#destroy
#          promotions_admin_index GET    /promotions(.:format)                   promotions_admin/admin#index
#                                 POST   /promotions(.:format)                   promotions_admin/admin#create
#            new_promotions_admin GET    /promotions/new(.:format)               promotions_admin/admin#new
#           edit_promotions_admin GET    /promotions/:id/edit(.:format)          promotions_admin/admin#edit
#                promotions_admin GET    /promotions/:id(.:format)               promotions_admin/admin#show
#                                 PATCH  /promotions/:id(.:format)               promotions_admin/admin#update
#                                 PUT    /promotions/:id(.:format)               promotions_admin/admin#update
#                                 DELETE /promotions/:id(.:format)               promotions_admin/admin#destroy
#            receipts_admin_index GET    /receipts(.:format)                     receipts_admin/admin#index
#                                 POST   /receipts(.:format)                     receipts_admin/admin#create
#              new_receipts_admin GET    /receipts/new(.:format)                 receipts_admin/admin#new
#             edit_receipts_admin GET    /receipts/:id/edit(.:format)            receipts_admin/admin#edit
#                  receipts_admin GET    /receipts/:id(.:format)                 receipts_admin/admin#show
#                                 PATCH  /receipts/:id(.:format)                 receipts_admin/admin#update
#                                 PUT    /receipts/:id(.:format)                 receipts_admin/admin#update
#                                 DELETE /receipts/:id(.:format)                 receipts_admin/admin#destroy
#               users_admin_index GET    /users(.:format)                        users_admin/admin#index
#                                 POST   /users(.:format)                        users_admin/admin#create
#                 new_users_admin GET    /users/new(.:format)                    users_admin/admin#new
#                edit_users_admin GET    /users/:id/edit(.:format)               users_admin/admin#edit
#                     users_admin GET    /users/:id(.:format)                    users_admin/admin#show
#                                 PATCH  /users/:id(.:format)                    users_admin/admin#update
#                                 PUT    /users/:id(.:format)                    users_admin/admin#update
#                                 DELETE /users/:id(.:format)                    users_admin/admin#destroy
#                            root GET    /                                       trestle/dashboard#index

Rails.application.routes.draw do
  root to: 'application#index'
  get 'retail', to: 'application#retail'
  get 'fmcg', to: 'application#fmcg'

  namespace :api do
    resources :home, only: %i[index]
    resources :receipts, only: %i[index create]
    resource :user, only: %i[create show update]
    resources :user_token, only: %i[create]
  end

  namespace :apm do
    resources :callback, only: %i[create]
  end
end
