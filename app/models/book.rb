class Book < ApplicationRecord
  # ▼ 書籍は特定のユーザーのものです ▼
  belongs_to :user

  validates :title, presence: true
  validates :progress, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
end