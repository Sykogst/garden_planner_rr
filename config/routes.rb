Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/plots', to: 'plots#index'
  get '/plots/new', to: 'plots#new'
  get '/plots/:id', to: 'plots#show'
  get '/plots/:id/edit', to: 'plots#edit'
  post '/plots', to: 'plots#create'
  patch '/plots/:id/update', to: 'plots#update'

  get '/organisms', to: 'organisms#index'
  get '/organisms/:id', to: 'organisms#show'
  get '/organisms/:id/edit', to: 'organisms#edit'

  get '/plots/:plot_id/organisms', to: 'plot_organisms#index'
  get '/plots/:plot_id/organisms/new', to: 'plot_organisms#new'
  post '/plots/:plot_id/organisms', to: 'plot_organisms#create'
end
