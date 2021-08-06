Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_for :users, controllers: { registrations: 'api/v1/users/registrations', sessions: 'api/v1/users/sessions' }
      
      namespace :admin do
        resources :users, only: :index
      end
      
    end
  end
end
