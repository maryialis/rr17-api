Rails.application.routes.draw do
  root to: 'source_provider#version'
  get '/source_providers', to: 'source_provider#index'
  get '/source_providers/:id', to: 'source_provider#show'
  post '/source_providers', to: 'source_provider#create'
  get '/users', to: 'user#index'
  get '/users/:id', to: 'user#show'
  post '/users', to: 'user#create'
  get '/courses', to: 'course_result#current'
  get '/courses/history', to: 'course_result#history'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
