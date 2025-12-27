Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, defaults: { format: :json }
  
  namespace :api do
    namespace :v1 do
      resources :code_submissions
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end