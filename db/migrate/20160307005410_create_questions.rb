class CreateQuestions < ActiveRecord::Migration
        def change
                create_table :questions do |t|
                        t.text :content
                        t.references :topic
                        t.boolean :required

                        t.timestamps null: false
                end

                add_column :topics, :enroll, :boolean
        end
end
