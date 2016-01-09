class AddCategoryReferenceToTopic < ActiveRecord::Migration
        def change
                add_reference :topics, :category
        end
end
