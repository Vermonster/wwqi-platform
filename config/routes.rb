WwqiPlatform::Application.routes.draw do
  get "autocomplete/users"

  devise_for :users

  resources :posts, path: "threads" do
    resources :comments
  end
  resources :researches do
    resources :comments
  end
  
  root :to => 'site#index'
end
