Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, skip: [:registrations]

  as :user do
    get 'users/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
    post 'users' => 'devise/registrations#create', as: 'user_registration'
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users' => 'devise/registrations#update'
    put 'users' => 'devise/registrations#update'
    get 'users/sign_out' => 'users/sessions#destroy'
  end

      
  authenticated :user, ->(u) { u.user_type == 'academic' } do
    root to: 'academics#dashboard', as: :academic_root
  end

  authenticated :user, ->(u) { u.user_type == 'recruiter' } do
    root to: 'recruiters#dashboard', as: :recruiter_root
  end
    
  resources :jobs do
    resources :applications, only: [:new, :create]
    end
  
  get 'all_jobs', to: 'jobs#all_jobs', as: 'all_jobs'

end
