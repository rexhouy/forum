class AddPriorityToTopics < ActiveRecord::Migration
        def change
                add_column :topics, :priority, :boolean
        end
end
