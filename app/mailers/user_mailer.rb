class UserMailer < ApplicationMailer
    def forgot_password(user)
        @user = User.find(user)
        @email = @user.employee.company_email
        @greeting = "Hello!"
        mail(to: @email, :subject => 'Magicell Magicnet Password Reset')
    end
end