Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: 'dashboard#index', as: :authenticated_root
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'home#index'
  resources :courses do
    get 'assign_student', on: :member
    get 'grade_student', on: :member
    post 'assign_student_grade', on: :collection
    post 'assign_student_to_course', on: :collection
    get 'students', on: :member
  end
  resources :students do
    get 'grades', on: :member
    get 'courses', on: :member
    get 'dashboard', on: :collection
  end
  # get 'student/dashboard', to: 'students#dashboard', as: 'student_dashboard'
  #get 'admin/dashboard', to: 'admin#dashboard', as: 'admin_dashboard'
  #get 'admin/new_user', to: 'admin#new_user', as: :new_user_admin
  #get 'admin/students', to: 'admin#students', as: :admin_students
  #post 'admin/users', to: 'admin#create_user', as: :admin_users
  scope '/admin' do
    get 'dashboard', to: 'admin#dashboard', as: 'admin_dashboard'
    get 'new_user', to: 'admin#new_user', as: :new_user_admin
    post 'users', to: 'admin#create_user', as: :admin_users
    get 'students', to: 'admin#students', as: :admin_students
  end
end
