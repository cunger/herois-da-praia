Rails.application.routes.draw do
  root 'welcome#start'

  resources :scopes, only: [:index, :show, :new, :create] do
    # Routes for logging beach clean data.
    get    'items', to: 'items#index',   on: :member
    patch  'items', to: 'items#update',  on: :member
    delete 'items', to: 'items#destroy', on: :member

    # Routes for logging whale watching data.
    resources :observations
  end

  # Routes for inspecting data.
  get 'analytics' => 'analytics#start'
end
