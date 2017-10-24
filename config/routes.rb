Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { registrations: "user_registrations" }
  
  resources :products do
    resources :comments
  end
  resources :users

  mount ActionCable.server => '/cable'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/index'
  get 'static_pages/landing_page'

  get 'products/index'

  get 'static_pages/payment_thank_you'

  post 'static_pages/thank_you'

  post 'payments/create'
  
  root 'static_pages#index'


  resources :orders, only: [:index, :show, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
