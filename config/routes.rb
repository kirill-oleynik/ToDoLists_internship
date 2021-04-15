Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

    namespace :api, path: '/', constaints: { subdomain: 'api' } do
      namespace :v1 do
        post 'sgn_up', to: 'registrations#create', as: 'sign_up'
        post 'sign_in', to: 'sessions#create', as: 'sign_in'
        put 'refresh_session', to: 'sessions#update', as: 'update_session'
        delete 'sign_out', to: 'sessions#destroy', as: 'sign_out'
      end
    end
end
