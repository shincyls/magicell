Rails.application.routes.draw do

  root 'statics#index'
  mount RailsAdmin::Engine => '/magicnet/admin', as: 'rails_admin'
  
  get 'magicnet', to: 'magicnets#login', as: 'login'
  get 'magicnet/dashboard', to: 'magicnets#dashboard', as: 'dashboard'
  # HR Pages' Route as below:
  get 'magicnet/view_hr/dashhr', to: 'magicnets#dashhr', as: 'dashhr'
  # EMP Pages' Route as below:
  get 'magicnet/view_emp/dashemployee', to: 'magicnets#dashemployee', as: 'dashemployee'
  get 'magicnet/view_emp/timesheetemployee', to: 'magicnets#timesheetemployee', as: 'timesheetemployee'
  get 'magicnet/view_emp/expenseemployee', to: 'magicnets#expenseemployee', as: 'expenseemployee'
  # FIN Pages' Route as below:
  get 'magicnet/view_fin/dashfinance', to: 'magicnets#dashfinance', as: 'dashfinance'
  # PM Pages' Route as below:
  get 'magicnet/view_pm/dashpm', to: 'magicnets#dashpm', as: 'dashpm'
  get 'magicnet/view_pm/approval', to: 'magicnets#approval', as: 'approval'
  # IT Pages' Route as below:
  get 'magicnet/view_it/dashboard', to: 'magicnets#dashit', as: 'dashit'
  get 'magicnet/view_it/webrole', to: 'magicnets#webrole', as: 'webrole'
  get 'magicnet/view_it/account', to: 'magicnets#account', as: 'account'

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
      post :leave_approval1
      post :leave_approval2
    end
  end

  resources :timesheets do
    collection do
    end
    member do
      get :taskadd
      get :approvaladd
      post :submit
    end
  end

  resources :timesheet_tasks do
    collection do
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

  # Expense
  resources :expenses do
    collection do
    end
    member do
      get :listadd
      get :approvaladd
      post :submit
    end
  end

  resources :expense_lists do
    collection do
    end
    member do
    end
  end

  resources :expense_approvals do
    collection do
    end
    member do
    end
  end

  resources :users do
    collection do
    end
    member do
      post :make
    end
  end

  resources :sessions

  # get 'statics/login', to: 'statics#login', as: 'modal_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
