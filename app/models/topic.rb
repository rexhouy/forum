class Topic < ActiveRecord::Base
        has_many :posts
        belongs_to :user

        validates :title, presence: true
        validates :content, presence: true
        validates :category_id, presence: true

end
