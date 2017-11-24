Rails.application.routes.draw do
  root 'static_pages#home'

  # for temporary static pages
  get  'static_pages/home'

  # for user login/logout
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
