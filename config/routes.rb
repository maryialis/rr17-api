Rails.application.routes.draw do
  get 'source_provider/version'

  get 'source_provider/source_providers'

  root 'source_provider#version'

  get '/source_providers', to: 'source_provider#source_providers'

  get '/source_providers/:id', to: 'source_provider#source_providers'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
