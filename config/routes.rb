Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :incoming do
        resources :messages, only: :create
      end
      namespace :outgoing do
        resources :messages, only: :create
      end
    end
  end
end
