WwqiPlatform::Application.routes.draw do
  devise_for :users

  resources :posts, path: "threads"
  
  root :to => 'site#index'
end
