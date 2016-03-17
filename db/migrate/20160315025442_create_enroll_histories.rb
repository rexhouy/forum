class CreateEnrollHistories < ActiveRecord::Migration
        def change
                create_table :enroll_histories do |t|
                        t.references :enroll
                        t.integer :status
                        t.integer :user_id
                        t.timestamps null: false
                end
        end
end
