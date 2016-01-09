class CreatePosts < ActiveRecord::Migration
        def change
                create_table :posts do |t|
                        t.text :content
                        t.integer :favorite

                        t.references :topic
                        t.references :user

                        t.timestamps null: false
                end
        end
end
