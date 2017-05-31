Rails.application.routes.draw do

  root to: 'source_providers#home'
  resources 'source_providers'
  resources 'users'
  resources 'source_parsers'
  get '/courses', to: 'course_results#current'
  get '/courses/history', to: 'course_results#history'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
