namespace :mail do
  desc "Sending weekly updates"
  task send_weekly: :environment do
    puts "Sending weekly updates"
    @users = User.left_joins(:mail_interval).where(mail_intervals: {interval: 7})
    @users.each do |user|
      UserMailer.with(user: user, interval: user.mail_interval.interval).whats_new_email.deliver_later
    end
  end

  desc "Sending daily updates"
  task send_daily: :environment do
    puts "Sending daily updates"
    @users = User.left_joins(:mail_interval).where(mail_intervals: {interval: 1})
    @users.each do |user|
      UserMailer.with(user: user, interval: user.mail_interval.interval).whats_new_email.deliver_later
    end
  end

end
