Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :coments
  end

  root  "posts#index"
end
