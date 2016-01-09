class CreateTopics < ActiveRecord::Migration
        def change
                create_table :topics do |t|
                        t.string :title
                        t.text :content
                        t.integer :favorite

                        t.references :user

                        t.timestamps null: false
                end
        end
end
