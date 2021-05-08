class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {minimum: 8}
  validates :description, presence: true, length: {minimum: 20}
end
