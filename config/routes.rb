Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

    namespace :api, path: '/', constaints: { subdomain: 'api' } do
      namespace :v1 do
        namespace :accounts do
          resource :registration, only: :create
          resource :session, only: %i[create update destroy]
        end
        resources :tasks
      end
    end
end
