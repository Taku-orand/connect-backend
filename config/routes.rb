Rails.application.routes.draw do
  #タグで検索 例）/tags/2/search
  resources :tags do
    get 'search', to: 'search#searchByTag'
  end
  
  # #文字列検索
  get 'search/:title', to: 'search#searchByWord'
  
  # サインイン関連
  post '/signup', to: 'registrations#signup'
  post '/signin', to: 'sessions#signin'
  delete '/signout', to: 'sessions#signout'
  get '/signed_in', to: 'sessions#signed_in?'
  
  # #answer用
  get 'answers/index' => 'answers#index'
  post 'answers/create' => 'answers#create'
  patch 'answers/update/:id' => 'answers#update'
  delete 'answers/destroy/:id' => 'answers#destroy'
  
  #question用
  get 'questions/index' => 'questions#index'
  get 'questions/show/:id' => 'questions#show'
  post 'questions/create' => 'questions#create'
  patch 'questions/update/:id' => 'questions#update'
  delete 'questions/destroy/:id' => 'questions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
