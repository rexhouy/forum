class CreateChats < ActiveRecord::Migration
        def change
                create_table :chats do |t|
                        t.text :text
                        t.string :name
                        t.string :avatar
                        t.timestamps null: false
                end
        end
end
