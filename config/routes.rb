Rails.application.routes.draw do
  root 'welcome#start'

  get 'welcome/how' => 'welcome#how'
  get 'welcome/why' => 'welcome#why'

  # Routes for logging beach clean data.

  resources :cleanups do
    post 'submit', on: :member

    resource :items, only: [:index, :new, :create] do
      post 'increase', on: :member
      post 'decrease', on: :member
      post 'reset', on: :collection
    end
  end

  # Routes for inspecting beach clean data.

  get 'analytics/start' => 'analytics#start'
end
