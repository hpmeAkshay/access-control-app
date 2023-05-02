class UserMailer < ApplicationMailer
    default from: 'from@example.com'

    def reset_password_email(user)
        @user= user
        @reset_password_url= edit_password_reset_url(user.reset_password_token)
        mail(to: @user.email, subject: 'Reset your password')
    end

end
