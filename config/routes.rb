Rails.application.routes.draw do

  root 'statics#index'
  mount RailsAdmin::Engine => '/magicnet/admin', as: 'rails_admin'
  # mount ActionCable.server => '/cable'
  
  get 'magicnet', to: 'magicnets#login', as: 'login'
  get 'magicnet/dashboard', to: 'magicnets#dashboard', as: 'dashboard'
  # HR Pages' Route as below:
  get 'magicnet/view_hr/dashhr', to: 'magicnets#dashhr', as: 'dashhr'
  # EMP Pages' Route as below:
  get 'magicnet/view_emp/dashemployee', to: 'magicnets#dashemployee', as: 'dashemployee'
  # get 'magicnet/view_emp/timesheetemployee', to: 'magicnets#timesheetemployee', as: 'timesheetemployee'
  # get 'magicnet/view_emp/expenseemployee', to: 'magicnets#expenseemployee', as: 'expenseemployee'
  # FIN Pages' Route as below:
  get 'magicnet/view_fin/dashfinance', to: 'magicnets#dashfinance', as: 'dashfinance'
  # get 'magicnet/view_fin/finance_timesheet', to: 'magicnets#finance_timesheet', as: 'finance_timesheet'
  # PM Pages' Route as below:
  get 'magicnet/view_pm/dashpm', to: 'magicnets#dashpm', as: 'dashpm'
  # get 'magicnet/view_pm/leave_approval', to: 'magicnets#leave_approval', as: 'leave_pm_approval'
  # get 'magicnet/view_pm/timesheet_approval', to: 'magicnets#timesheet_approval', as: 'timesheet_pm_approval'
  # get 'magicnet/view_pm/expense_approval', to: 'magicnets#expense_approval', as: 'expense_pm_approval'
  # IT Pages' Route as below:
  get 'magicnet/view_it/dashboard', to: 'magicnets#dashit', as: 'dashit'
  get 'magicnet/view_it/webrole', to: 'magicnets#webrole', as: 'webrole'
  get 'magicnet/view_it/account', to: 'magicnets#account', as: 'account'

  resources :password_resets
  
  resources :employees do
    collection do
      post :import
    end
    member do
      post :editself
      post :updateself
    end
  end

  resources :projects do
    collection do
      post :import
    end
    member do
    end
  end

  resources :holidays do
    collection do
    end
    member do
      post :activate
    end
  end

  resources :announcements do
    collection do
    end
    member do
      post :display
    end
  end

  # leave
  resources :leaveaps do
    collection do
      get :project
      post :submitall
      post :approveall
    end
    member do
      post :submit
      post :approve
      post :reject
    end
  end

  # Timesheet
  resources :timesheet_tasks do
    collection do
      get :project
      get :finance
      post :submitall
      post :approvepmall
      post :approvefmall
    end
    member do
      post :submit
      post :approvepm
      post :rejectpm
      post :approvefm
      post :rejectfm
    end
  end

  # Expense
  resources :expense_lists do
    collection do
      get :project
      get :finance
      post :submitall
      post :approvepmall
      post :approvefmall
    end
    member do
      post :submit
      post :approvepm
      post :rejectpm
      post :approvefm
      post :rejectfm
    end
  end

  resources :users do
    collection do
    end
    member do
      post :make
      get :role
    end
  end

  resources :sessions

  # get 'statics/login', to: 'statics#login', as: 'modal_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
