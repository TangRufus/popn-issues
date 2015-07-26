# == Route Map
#
#                   Prefix Verb   URI Pattern                         Controller#Action
#                 comments GET    /comments(.:format)                 comments#index
#                          POST   /comments(.:format)                 comments#create
#              new_comment GET    /comments/new(.:format)             comments#new
#             edit_comment GET    /comments/:id/edit(.:format)        comments#edit
#                  comment GET    /comments/:id(.:format)             comments#show
#                          PATCH  /comments/:id(.:format)             comments#update
#                          PUT    /comments/:id(.:format)             comments#update
#                          DELETE /comments/:id(.:format)             comments#destroy
#         new_user_session GET    /users/sign_in(.:format)            devise/sessions#new
#             user_session POST   /users/sign_in(.:format)            devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)           devise/sessions#destroy
#            user_password POST   /users/password(.:format)           devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)       devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)      devise/passwords#edit
#                          PATCH  /users/password(.:format)           devise/passwords#update
#                          PUT    /users/password(.:format)           devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)             devise/registrations#cancel
#        user_registration POST   /users(.:format)                    devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)            devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)               devise/registrations#edit
#                          PATCH  /users(.:format)                    devise/registrations#update
#                          PUT    /users(.:format)                    devise/registrations#update
#                          DELETE /users(.:format)                    devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)       devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format)   devise/confirmations#new
#                          GET    /users/confirmation(.:format)       devise/confirmations#show
#              user_unlock POST   /users/unlock(.:format)             devise/unlocks#create
#          new_user_unlock GET    /users/unlock/new(.:format)         devise/unlocks#new
#                          GET    /users/unlock(.:format)             devise/unlocks#show
#      change_status_issue PATCH  /issues/:id/change_status(.:format) issues#change_status
#                   issues GET    /issues(.:format)                   issues#index
#                          POST   /issues(.:format)                   issues#create
#                new_issue GET    /issues/new(.:format)               issues#new
#               edit_issue GET    /issues/:id/edit(.:format)          issues#edit
#                    issue GET    /issues/:id(.:format)               issues#show
#                          PATCH  /issues/:id(.:format)               issues#update
#                          PUT    /issues/:id(.:format)               issues#update
#                          DELETE /issues/:id(.:format)               issues#destroy
#              sidekiq_web        /sidekiq                            Sidekiq::Web
#                     root GET    /                                   issues#index
#

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :issues do
    member do
      patch 'change_status', to: 'issues#change_status'
    end
  end

  authenticated :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'issues#index'
end
