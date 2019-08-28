Rails.application.routes.draw do

  root 'statics#index'
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  get 'magicnet', to: 'magicnets#login', as: 'login'
  get 'magicnet/dashboard', to: 'magicnets#dashboard', as: 'dashboard'

  resources :leaveaps do
    collection do
    end
    member do
    end
  end

  resources :timesheets do
    collection do
      get :retrieve
    end
    member do
    end
  end

  resources :timesheet_approvals do
    collection do
    end
    member do
    end
  end

  resources :users
  resources :sessions

  # get 'statics/login', to: 'statics#login', as: 'modal_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
