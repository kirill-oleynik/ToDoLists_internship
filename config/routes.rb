Rails.application.routes.draw do
  post 'session', to: 'sessions#create', as: 'create_session'
  put 'session', to: 'sessions#update', as: 'update_session'
  delete 'session', to: 'sessions#destroy', as: 'delete_session'
  post "/graphql", to: "graphql#execute"
    namespace :api, path: '/', constaints: { subdomain: 'api' } do
      namespace :v1 do
  resources :users, except: :index
      end
    end
end
