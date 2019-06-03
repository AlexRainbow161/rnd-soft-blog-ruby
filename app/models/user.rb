class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :about, length: { maximum: 400 }
  validates :name, format: { with: /\A[a-zA-Z0-9А-Яа-я]+\Z/ }
  has_many :subscribes
  has_many :news
  belongs_to :subscribe_type
  belongs_to :mail_interval
  has_one_attached :image
  has_many :comments
  has_many :likes
  self.per_page = 10

  before_validation do |user|
    user.name = user.name.capitalize if user.name
    user.lastname = user.lastname.capitalize if user.lastname
    user.mail_interval = MailInterval.find_by interval: 7 unless user.mail_interval
    user.subscribe_type = SubscribeType.find_by _type: "all" unless user.subscribe_type
  end

  after_create do |user|
    user.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'user_default.png')), filename: 'user_default.png', content_type: 'image/png')
    UserMailer.with(user: user).welcome_email.deliver_later
  end
end
