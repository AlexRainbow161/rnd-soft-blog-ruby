class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :subscribes
  has_many :news
  has_one :user_profile
  has_one_attached :image
  self.per_page = 10

  after_create do |user|
    user.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'user_default.png')), filename: 'user_default.png', content_type: 'image/png')
    user.mail_interval = 7
    user.save
  end

end
