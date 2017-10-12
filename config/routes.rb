Rails.application.routes.draw do
  resources :post

  root  "posts#index"
end
