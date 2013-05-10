WwqiPlatform::Application.routes.draw do
  root :to => 'site#index'

  get "autocomplete/users"

  resources :users do
    resources :notifications
  end

  resources :posts, controller: :threads, path: :threads do
    resources :comments
  end
  
  resources :researches do
    resources :comments
  end

  resources :contributions do
    resources :comments
  end
  
  resources :corrections
  
  match "/me" => "profile#show", :as => 'my_profile'
  match "/me/notifications" => "profile#notifications", :as => 'my_notifications'

  devise_scope :user do
    get    '/users/sign_in(.:format)'       => 'site#index', as: 'new_user_session'
    post   '/users/sign_in(.:format)'       => 'devise/sessions#create', as: 'user_session'
    delete '/users/sign_out(.:format)'      => 'devise/sessions#destroy', as: 'destroy_user_session'

    post   '/users/password(.:format)'      => 'devise/passwords#create', as: 'user_password'
    get    '/users/password/new(.:format)'  => 'devise/passwords#new', as: 'new_user_password'
    get    '/users/password/edit(.:format)' => 'devise/passwords#edit', as: 'edit_user_password'
    put    '/users/password(.:format)'      => 'devise/passwords#update'

    get    '/users/cancel(.:format)'        => 'devise/registrations#cancel', as: 'cancel_user_registration'
    post   '/users(.:format)'               => 'devise/registrations#create', as: 'user_registration'
    get    '/users/sign_up(.:format)'       => 'site#index', as: 'new_user_registration'
    get    '/users/edit(.:format)'          => 'devise/registrations#edit', as: 'edit_user_registration'
    put    '/users(.:format)'               => 'devise/registrations#update'
    delete '/users(.:format)'               => 'devise/registrations#destroy'
  end
end
