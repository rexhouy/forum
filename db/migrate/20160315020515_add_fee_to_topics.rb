class AddFeeToTopics < ActiveRecord::Migration
        def change
                add_column :topics, :enroll_fee, :decimal, precision: 8, scale: 2
        end
end
