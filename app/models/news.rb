class News < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    self.per_page = 5
end
