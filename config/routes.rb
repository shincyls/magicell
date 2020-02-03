Rails.application.routes.draw do

  root 'statics#index'
  mount RailsAdmin::Engine => '/magicnet/admin', as: 'rails_admin'
  # mount ActionCable.server => '/cable'
  
  get 'magicnet', to: 'magicnets#login', as: 'login'
  get 'magicnet/dashboard', to: 'magicnets#dashboard', as: 'dashboard'
  get 'magicnet/approve_leave', to: 'magicnets#approve_leave', as: 'approve_leave'
  # HR Pages' Route as below:
  get 'magicnet/view_hr/dashhr', to: 'magicnets#dashhr', as: 'dashhr'
  get 'magicnet/view_hr/taskhr', to: 'magicnets#taskhr', as: 'taskhr'
  # EMP Pages' Route as below:
  get 'magicnet/view_emp/dashemployee', to: 'magicnets#dashemployee', as: 'dashemployee'
  # FIN Pages' Route as below:
  get 'magicnet/view_fin/dashfinance', to: 'magicnets#dashfinance', as: 'dashfinance'
  # PM Pages' Route as below:
  get 'magicnet/view_pm/dashpm', to: 'magicnets#dashpm', as: 'dashpm'
  # IT Pages' Route as below:
  get 'magicnet/view_it/dashboard', to: 'magicnets#dashit', as: 'dashit'
  get 'magicnet/view_it/webrole', to: 'magicnets#webrole', as: 'webrole'
  get 'magicnet/view_it/account', to: 'magicnets#account', as: 'account'

  # Reporting Pages
  get 'magicnet/reports', to: 'reports#index', as: 'reports'
  get 'magicnet/reports/employee', to: 'reports#employee', as: 'employee_reports'
  get 'magicnet/reports/project', to: 'reports#project', as: 'project_reports'
  get 'magicnet/reports/leave', to: 'reports#leave', as: 'leave_reports'
  get 'magicnet/reports/employee/:id/details', to: 'reports#employee_details', as: 'employee_details_reports'
  get 'magicnet/reports/project/:id/details', to: 'reports#project_details', as: 'project_details_reports'

  resources :password_resets
  
  resources :employees do
    collection do
      post :import
      post :update_leaves
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
