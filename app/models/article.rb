class Article < ApplicationRecord
    #un articolo può appartenere ad un solo user
    belongs_to :user

    has_many :article_categories
    has_many :categories, through: :article_categories

    validates :title, presence: true, length: {minimum: 5, maximum: 100}
    validates :description, presence: true, length: {minimum: 5, maximum: 1000}
end
  