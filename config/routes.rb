WwqiPlatform::Application.routes.draw do
  devise_for :users

  resources :posts, path: "threads" do
    resources :comments
  end
  resources :researches do
    resources :comments
  end
  
  root :to => 'site#index'
end
