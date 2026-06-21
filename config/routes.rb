Rails.application.routes.draw do
  devise_for :users
  # 書籍（books）に関する標準的なURL（CRUD）を一括で有効にします
  resources :books
  
  # アプリのトップページ（ http://localhost:3000/ ）にアクセスしたときも、書籍一覧を表示するようにします
  root "books#index"
end