Rails.application.routes.draw do
  root 'welcome#start'

  get 'welcome/start' => 'welcome#start'
  get 'welcome/info'  => 'welcome#info'

  # Routes for logging beach clean data.

  resources :cleanups do
    post 'submit', on: :member
    post 'reset', on: :member

    post   'items/:id', to: 'items#create', on: :member
    delete 'items/:id', to: 'items#destroy', on: :member
  end

  # Routes for inspecting beach clean data.

  get 'analytics/start' => 'analytics#start'
end
