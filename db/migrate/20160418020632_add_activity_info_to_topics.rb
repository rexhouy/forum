class AddActivityInfoToTopics < ActiveRecord::Migration
        def change
                add_column :topics, :enroll_start_date, :datetime
                add_column :topics, :enroll_end_date, :datetime
                add_column :topics, :start_time, :datetime
                add_column :topics, :location, :string
                add_column :topics, :min_places, :integer
                add_column :topics, :max_places, :integer
        end
end
