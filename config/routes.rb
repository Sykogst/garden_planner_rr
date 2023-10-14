Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/plots', to: 'plots#index'
  get '/plots/:id', to: 'plots#show'
  get '/plots/new', to: 'plots#new'

  get '/organisms', to: 'organisms#index'
  get '/organisms/:id', to: 'organisms#show'

  get '/plots/:plot_id/organisms', to: 'plot_organisms#index'
end
