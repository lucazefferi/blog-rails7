class User < ApplicationRecord
    #uniqueness: true -> rende unico lo username di default tiene conto delle maiuscole e minuscole quindi ("Luca" e "luca" per lui sono due string differenti)
    validates :username, uniqueness: true, 
                         presence: true, length: {minimum: 3, maximum: 25}

    VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    #uniqueness: { case_sensitive: false} -> rende unico l'email e non tiene conto delle maiuscole e minuscole quindi ("Luca" e "luca" per lui sono due string uguali)
    validates :email, uniqueness: { case_sensitive: false},
                      presence: true, length: { maximum: 100},
                      format:{with:VALID_EMAIL_REGEX,multiline:true}

                    

    
   
end