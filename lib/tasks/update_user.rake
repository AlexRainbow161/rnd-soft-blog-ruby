namespace :update_user do
  desc "Update all exists user for default mailing interval"
  task update_mail_interval: :environment do
    users = User.all
    users.each do |user|
      user.mail_interval = 7
      user.save
    end
  end

  desc "Update user empty pictures"
  task set_default_picture: :environment do
    users = User.all
    users.each do |user|
      user.image = "/app/assets/images/user_default.png" if !user.image.attached?
      user.save
    end
  end
end
