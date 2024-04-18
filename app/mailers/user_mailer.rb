class UserMailer < ApplicationMailer
    def goodbye_email(user)
      @user = user
      mail(to: @user.email, subject: 'Addio da BlogCreator')
    end
end