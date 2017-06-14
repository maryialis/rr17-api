Rails.application.routes.draw do

  namespace :v1 do
    # root to: 'source_providers#home'
    resources 'source_providers'
    post 'source_providers/:id/start_now', to: 'source_providers#parse_now'
    post 'source_providers/parse_all', to: 'source_providers#parse_all'
    resources 'users'
    resources 'source_parsers'
    get '/courses', to: 'course_results#current'
    get '/courses/history', to: 'course_results#history'
    # post '/login', to: "sessions#create"  

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
