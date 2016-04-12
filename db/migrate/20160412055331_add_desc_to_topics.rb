class AddDescToTopics < ActiveRecord::Migration
        def change
                add_column :topics, :desc, :string
                add_column :topics, :cover_image, :string
        end
end
