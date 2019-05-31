class Subscribe < ApplicationRecord
    belongs_to :user
    has_one :s_user, foreign_key: :id, primary_key: :s_user_id, :class_name => "User"
    self.per_page = 10
end
