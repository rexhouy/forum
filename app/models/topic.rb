class Topic < ActiveRecord::Base
        has_many :posts
        belongs_to :user
        has_many :user_favorites

        validates :title, presence: true
        validates :content, presence: true
        validates :category_id, presence: true

        before_create do
                self.favorite = 0
        end

end
