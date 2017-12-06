Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/about', as: 'about'

  # for user login/logout
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users do
    get :map
  end
  resources :satellites


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
