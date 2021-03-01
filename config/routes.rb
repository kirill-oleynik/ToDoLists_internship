Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
    namespace :api, path: '/', constaints: { subdomain: 'api' } do
      namespace :v1 do
  resources :users, except: :index
      end
    end
end
