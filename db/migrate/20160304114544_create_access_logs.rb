class CreateAccessLogs < ActiveRecord::Migration
        def change
                create_table :access_logs do |t|
                        t.string :resource_name, null: false
                        t.integer :resource_id, null: false
                        t.integer :user_id
                        t.timestamps null: false
                end
        end
end
