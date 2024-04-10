class Article < ApplicationRecord
    #un articolo può appartenere ad un solo user
    belongs_to :user
    validates :title, presence: true, length: {minimum: 5, maximum: 100}
    validates :description, presence: true, length: {minimum: 5, maximum: 1000}
end
  