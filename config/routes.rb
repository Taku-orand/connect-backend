Rails.application.routes.draw do
  #connectにアクセスすれば, 質問一覧のページにいく
  root to: 'questions#index'

  #タグで検索 例）/tags/2/search
  resources :tags do
    get 'search', to: 'search#searchByTag'
  end

  #文字列検索
  get 'search/:title', to: 'search#searchByWord'

  # サインイン関連
  post '/signup', to: 'registrations#signup'
  post '/signin', to: 'sessions#signin'
  delete '/signout', to: 'sessions#signout'
  get '/signed_in', to: 'sessions#signed_in?'

  #answer用
  get "answers/index"
  post "answers/create"
  patch "answers/update/:id"
  delete "answers/destroy/:id"

  #question用
  get 'questions/index'
  get 'questions/show/:id'
  post 'questions/create'
  patch 'questions/update/:id'
  delete 'questions/destroy/:id'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
