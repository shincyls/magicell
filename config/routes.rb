Rails.application.routes.draw do

  root 'statics#index'
  mount RailsAdmin::Engine => '/magicenet/admin', as: 'rails_admin'
  
  get 'magicnet', to: 'magicnets#login', as: 'login'
  get 'magicnet/dashboard', to: 'magicnets#dashboard', as: 'dashboard'
  get 'magicnet/dashboardhr', to: 'magicnets#dashboardhr', as: 'dashboardhr'
  get 'magicnet/dashmanager', to: 'magicnets#dashmanager', as: 'dashmanager'
  get 'magicnet/dashinfotech', to: 'magicnets#dashinfotech', as: 'dashinfotech'
  get 'magicnet/dashemployee', to: 'magicnets#dashemployee', as: 'dashemployee'
  get 'magicnet/dashfinance', to: 'magicnets#dashfinance', as: 'dashfinance'

  resources :employees do
    collection do
    end
    member do
    end
  end

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
