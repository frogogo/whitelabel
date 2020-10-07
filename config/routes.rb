# == Route Map
#
#                        Prefix Verb  URI Pattern                                                                              Controller#Action
#                       trestle       /admin                                                                                   Trestle::Engine
#                api_home_index GET   /api/home(.:format)                                                                      api/home#index
#                  api_receipts GET   /api/receipts(.:format)                                                                  api/receipts#index
#                               POST  /api/receipts(.:format)                                                                  api/receipts#create
#                      api_user GET   /api/user(.:format)                                                                      api/users#show
#                               PATCH /api/user(.:format)                                                                      api/users#update
#                               PUT   /api/user(.:format)                                                                      api/users#update
#                               POST  /api/user(.:format)                                                                      api/users#create
#          api_user_token_index POST  /api/user_token(.:format)                                                                api/user_token#create
#    assign_api_vending_machine POST  /api/vending_machines/:id/assign(.:format)                                               api/venidng_machines#assign
# take_item_api_vending_machine POST  /api/vending_machines/:id/take_item(.:format)                                            api/vending_machines#take_item
#            rails_service_blob GET   /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#     rails_blob_representation GET   /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#            rails_disk_service GET   /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#     update_rails_disk_service PUT   /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#          rails_direct_uploads POST  /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
# Routes for Trestle::Engine:
#                             login GET    /login(.:format)                          trestle/auth/sessions#new
#                                   POST   /login(.:format)                          trestle/auth/sessions#create
#                            logout GET    /logout(.:format)                         trestle/auth/sessions#destroy
#   auth_administrators_admin_index GET    /auth/administrators(.:format)            auth/administrators_admin/admin#index
#                                   POST   /auth/administrators(.:format)            auth/administrators_admin/admin#create
#     new_auth_administrators_admin GET    /auth/administrators/new(.:format)        auth/administrators_admin/admin#new
#    edit_auth_administrators_admin GET    /auth/administrators/:id/edit(.:format)   auth/administrators_admin/admin#edit
#         auth_administrators_admin GET    /auth/administrators/:id(.:format)        auth/administrators_admin/admin#show
#                                   PATCH  /auth/administrators/:id(.:format)        auth/administrators_admin/admin#update
#                                   PUT    /auth/administrators/:id(.:format)        auth/administrators_admin/admin#update
#                                   DELETE /auth/administrators/:id(.:format)        auth/administrators_admin/admin#destroy
# distribution_networks_admin_index GET    /distribution_networks(.:format)          distribution_networks_admin/admin#index
#                                   POST   /distribution_networks(.:format)          distribution_networks_admin/admin#create
#   new_distribution_networks_admin GET    /distribution_networks/new(.:format)      distribution_networks_admin/admin#new
#  edit_distribution_networks_admin GET    /distribution_networks/:id/edit(.:format) distribution_networks_admin/admin#edit
#       distribution_networks_admin GET    /distribution_networks/:id(.:format)      distribution_networks_admin/admin#show
#                                   PATCH  /distribution_networks/:id(.:format)      distribution_networks_admin/admin#update
#                                   PUT    /distribution_networks/:id(.:format)      distribution_networks_admin/admin#update
#                                   DELETE /distribution_networks/:id(.:format)      distribution_networks_admin/admin#destroy
#                 items_admin_index GET    /items(.:format)                          items_admin/admin#index
#                                   POST   /items(.:format)                          items_admin/admin#create
#                   new_items_admin GET    /items/new(.:format)                      items_admin/admin#new
#                  edit_items_admin GET    /items/:id/edit(.:format)                 items_admin/admin#edit
#                       items_admin GET    /items/:id(.:format)                      items_admin/admin#show
#                                   PATCH  /items/:id(.:format)                      items_admin/admin#update
#                                   PUT    /items/:id(.:format)                      items_admin/admin#update
#                                   DELETE /items/:id(.:format)                      items_admin/admin#destroy
#         manufacturers_admin_index GET    /manufacturers(.:format)                  manufacturers_admin/admin#index
#                                   POST   /manufacturers(.:format)                  manufacturers_admin/admin#create
#           new_manufacturers_admin GET    /manufacturers/new(.:format)              manufacturers_admin/admin#new
#          edit_manufacturers_admin GET    /manufacturers/:id/edit(.:format)         manufacturers_admin/admin#edit
#               manufacturers_admin GET    /manufacturers/:id(.:format)              manufacturers_admin/admin#show
#                                   PATCH  /manufacturers/:id(.:format)              manufacturers_admin/admin#update
#                                   PUT    /manufacturers/:id(.:format)              manufacturers_admin/admin#update
#                                   DELETE /manufacturers/:id(.:format)              manufacturers_admin/admin#destroy
#            promotions_admin_index GET    /promotions(.:format)                     promotions_admin/admin#index
#                                   POST   /promotions(.:format)                     promotions_admin/admin#create
#              new_promotions_admin GET    /promotions/new(.:format)                 promotions_admin/admin#new
#             edit_promotions_admin GET    /promotions/:id/edit(.:format)            promotions_admin/admin#edit
#                  promotions_admin GET    /promotions/:id(.:format)                 promotions_admin/admin#show
#                                   PATCH  /promotions/:id(.:format)                 promotions_admin/admin#update
#                                   PUT    /promotions/:id(.:format)                 promotions_admin/admin#update
#                                   DELETE /promotions/:id(.:format)                 promotions_admin/admin#destroy
#              receipts_admin_index GET    /receipts(.:format)                       receipts_admin/admin#index
#                                   POST   /receipts(.:format)                       receipts_admin/admin#create
#                new_receipts_admin GET    /receipts/new(.:format)                   receipts_admin/admin#new
#               edit_receipts_admin GET    /receipts/:id/edit(.:format)              receipts_admin/admin#edit
#                    receipts_admin GET    /receipts/:id(.:format)                   receipts_admin/admin#show
#                                   PATCH  /receipts/:id(.:format)                   receipts_admin/admin#update
#                                   PUT    /receipts/:id(.:format)                   receipts_admin/admin#update
#                                   DELETE /receipts/:id(.:format)                   receipts_admin/admin#destroy
#                 users_admin_index GET    /users(.:format)                          users_admin/admin#index
#                                   POST   /users(.:format)                          users_admin/admin#create
#                   new_users_admin GET    /users/new(.:format)                      users_admin/admin#new
#                  edit_users_admin GET    /users/:id/edit(.:format)                 users_admin/admin#edit
#                       users_admin GET    /users/:id(.:format)                      users_admin/admin#show
#                                   PATCH  /users/:id(.:format)                      users_admin/admin#update
#                                   PUT    /users/:id(.:format)                      users_admin/admin#update
#                                   DELETE /users/:id(.:format)                      users_admin/admin#destroy
#         vending_cells_admin_index GET    /vending_cells(.:format)                  vending_cells_admin/admin#index
#                                   POST   /vending_cells(.:format)                  vending_cells_admin/admin#create
#           new_vending_cells_admin GET    /vending_cells/new(.:format)              vending_cells_admin/admin#new
#          edit_vending_cells_admin GET    /vending_cells/:id/edit(.:format)         vending_cells_admin/admin#edit
#               vending_cells_admin GET    /vending_cells/:id(.:format)              vending_cells_admin/admin#show
#                                   PATCH  /vending_cells/:id(.:format)              vending_cells_admin/admin#update
#                                   PUT    /vending_cells/:id(.:format)              vending_cells_admin/admin#update
#                                   DELETE /vending_cells/:id(.:format)              vending_cells_admin/admin#destroy
#      vending_machines_admin_index GET    /vending_machines(.:format)               vending_machines_admin/admin#index
#                                   POST   /vending_machines(.:format)               vending_machines_admin/admin#create
#        new_vending_machines_admin GET    /vending_machines/new(.:format)           vending_machines_admin/admin#new
#       edit_vending_machines_admin GET    /vending_machines/:id/edit(.:format)      vending_machines_admin/admin#edit
#            vending_machines_admin GET    /vending_machines/:id(.:format)           vending_machines_admin/admin#show
#                                   PATCH  /vending_machines/:id(.:format)           vending_machines_admin/admin#update
#                                   PUT    /vending_machines/:id(.:format)           vending_machines_admin/admin#update
#                                   DELETE /vending_machines/:id(.:format)           vending_machines_admin/admin#destroy
#                              root GET    /                                         trestle/dashboard#index

Rails.application.routes.draw do
  namespace :api do
    resources :home, only: %i[index]
    resources :receipts, only: %i[index create]
    resource :user, only: %i[create show update]
    resources :user_token, only: %i[create]
    resources :vending_machines, only: %i[] do
      post 'assign', to: 'vending_machines#assign', on: :member
      post 'take_item', to: 'vending_machines#take_item', on: :member
    end
  end
end
