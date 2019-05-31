class UserMailer < ApplicationMailer
    default from: 'RND SOFT BLOG Info Service <xander.rei@gmail.com>'
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Приветствую! #{@user.name}")
    end
    def whats_new_email
        @user = params[:user]
        @interval = params[:interval]
        template_name = ""
        case @user.subscribe_type._type
        when "all"
            @news = News.where(created_at: @interval.day.ago.beginning_of_day..Time.zone.now).order(created_at: :desc)
            template_name = 'all'
        when "user_only"
            template_name = 'user_only'
        end
        mail(to: @user.email, subject: "#{@user.name} для вас есть обновления", template_name: template_name)
    end
end
