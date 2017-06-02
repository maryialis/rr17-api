Rails.application.routes.draw do

  root to: 'source_providers#home'
  get 'source_providers/parse_all', to: 'source_providers#parse_all'
  resources 'source_providers'
  get 'source_providers/:id/start_now', to: 'source_providers#parse_now'
  resources 'users'
  resources 'source_parsers'
  get '/courses', to: 'course_results#current'
  get '/courses/history', to: 'course_results#history'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
