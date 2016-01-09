class CreateCaptchas < ActiveRecord::Migration
        def change
                create_table :captchas, id: false do |t|
                        t.string :tel, limit: 11, null: false
                        t.string :register_token, null: false, limit: 6
                        t.datetime :register_sent_at, null: false
                        t.timestamps null: false
                end

                add_index :captchas, :tel, unique: true
        end
end
