Rails.application.routes.draw do

  get 'rails/routes'
  # root admin sign ups/logins
  root 'registrations#new'
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  # admin sign ins / logouts
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete 'logout', to: "sessions#destroy"
  # admin_home 
  get "admin_home", to: "admin#index"

  # eval controllers
  # resources :evaluations
  # admin eval views
  post 'create_evaluation', to: 'evaluations#create'
  delete 'delete_evaluation', to: 'evaluations#remove'
  get 'view_evaluation', to: 'evaluations#view'
  # user eval views 
  get "user_eval", to: "users#index_eval"
  get 'user_view', to: 'users#view'
  get 'edit_eval', to: 'evaluations#edit'
  patch 'user_eval', to: 'evaluations#update'

  # user home page and group routes
  get "user_home", to: "users#home"
  get "user_group", to: "users#index_group"
  get "score", to: "users#score"


  #project controllers
  resources :projects
  #assign projects to groups 
  get "assign_group", to: "projects#assign_group"
  post "assign_group", to: "projects#create_proj_group"
  delete "assign_group", to: "projects#remove_group"
  
  # create users
  resources :users

  # group and grouping controllers
  resources :groups 
  get 'add_to_group', to: 'groups#add_user' 
  post 'add_to_group', to: 'groups#create_grouping'
  delete 'add_to_group', to: 'groups#remove_user'
  
  # main login page root
  # root 'sessions#login'

  

  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end