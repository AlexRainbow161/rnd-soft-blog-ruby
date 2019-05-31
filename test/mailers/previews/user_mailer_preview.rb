# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def welcome_email
        @user = User.find(3)
        UserMailer.with(user: @user).welcome_email
    end

    def whats_new_email
        @user = User.find(2)
        UserMailer.with(user: @user, interval: @user.mail_interval.interval).whats_new_email
    end
end
