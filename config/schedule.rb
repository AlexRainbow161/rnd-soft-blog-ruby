every 1.day, at: '07:00 am' do
  rake "mail:send_daily"
end

every 1.week, at: '07:00 am' do
  rake "mail:send_weekly"
end