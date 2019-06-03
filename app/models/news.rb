class News < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    has_many :comments
    has_many :likes
    self.per_page = 5
end
