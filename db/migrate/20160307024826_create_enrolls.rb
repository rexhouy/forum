class CreateEnrolls < ActiveRecord::Migration
        def change
                create_table :enrolls do |t|
                        t.text :content
                        t.references :user
                        t.references :topic

                        t.timestamps null: false
                end
        end
end
