Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'

  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'

  get '/pets/:id', to: 'pets#show'
  get '/pets', to: 'pets#index'

  # when rails sees get '/shelters/new' it would route to 'shelters/:id' because it thinks new = :id
  # it checks each route one by one from top to bottom to see if the request it received matches each route listed here
end
