class Category < ApplicationRecord

    #uniqueness: { case_sensitive: false} -> rende unico l'email e non tiene conto delle maiuscole e minuscole quindi ("Sport" e "sport" per lui sono due string uguali)
    validates :name, presence: true, uniqueness: { case_sensitive: false}, length: {minimum: 5, maximum: 100}

    has_many :article_categories
    has_many :articles, through: :article_categories

end
