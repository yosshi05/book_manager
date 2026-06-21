class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ▼ ユーザーはたくさんの書籍を持っています（退会したら本も一緒に消える設定） ▼
  has_many :books, dependent: :destroy
end