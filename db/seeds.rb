# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless SubscribeType.all.count != 0
    puts "creating types"
    subscribe__types = SubscribeType.create!([{name: "Все обновления", _type: "all"}, {name: "Только мои", _type: "user_only"}])
    subscribe__types.each do |typ|
        puts typ.name
    end
else
    puts "Already created"
end
unless MailInterval.all.count != 0
    puts "creating intervals"
    mail_intervals = MailInterval.create!([{name: "Еженедельно", interval: 7}, {name: "Ежедневно", interval: 1}, {name: "Отключено", interval: 0}])
    mail_intervals.each do |interval|
        puts interval.name
    end
else
    puts "Already created"
end