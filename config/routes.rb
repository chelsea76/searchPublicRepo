Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'search', to: 'search#index', as: :search
  post 'submit', to: 'search#submit'
  root to: 'search#index'
end
