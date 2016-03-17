class AddEnrollPromotionToTopics < ActiveRecord::Migration
        def change
                add_column :topics, :enroll_promotion, :decimal, precision: 8, scale: 2
        end
end
