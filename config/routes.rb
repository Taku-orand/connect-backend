Rails.application.routes.draw do
  #タグで検索 例）/tags/2/search
  get 'tag/:id', to: 'search#searchByTag'
  
  # #文字列検索
  get 'search/', to: 'search#searchByWord'
  
  # サインイン関連
  post '/signup', to: 'registrations#signup'
  post '/signin', to: 'sessions#signin'
  delete '/signout', to: 'sessions#signout'
  get '/signed_in', to: 'sessions#signed_in?'
  
  # #answer用
  get 'answers/show/:id' => 'answers#show'
  post 'answers/create' => 'answers#create'
  patch 'answers/update/:id' => 'answers#update'
  delete 'answers/destroy/:id' => 'answers#destroy'
  
  #question用
  get 'questions/index' => 'questions#index'
  get 'questions/show/:id' => 'questions#show'
  get 'questions/user' => 'questions#user'
  post 'questions/create' => 'questions#create'
  patch 'questions/update/:id' => 'questions#update'
  delete 'questions/destroy/:id' => 'questions#destroy'

  #feedback用
  get 'requests/index' => 'requests#index'
  get 'requests/show/:id' => 'requests#show'
  post 'requests/create' => 'requests#create'

  #like用
  post 'like/add/:id' => 'like#add'

  #sort用
  get 'sort/date_desc' => 'sort#date_desc'
  get 'sort/date_asc' => 'sort#date_asc'
  get 'sort/like_desc' => 'sort#like_desc'
  get 'sort/like_asc' => 'sort#like_asc'
  get 'sort/solved' => 'sort#solved'
  get 'sort/unsolved' => 'sort#unsolved'
  
  #tag用
  get 'tags/index' => 'tags#index'
  get 'tags/show/:id' => 'tags#show'
  post 'tags/create' => 'tags#create'
  patch 'tags/update/:id' => 'tags#update'
  delete 'tags/destroy/:id' => 'tags#destroy'

  # notification用
  get 'notifications/index' => 'notifications#index'
end
