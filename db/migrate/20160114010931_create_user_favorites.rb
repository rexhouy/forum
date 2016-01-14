class CreateUserFavorites < ActiveRecord::Migration
        def change
                create_table :user_favorites do |t|
                        t.references :user
                        t.references :topic

                        t.timestamps null: false
                end

                add_index :user_favorites, [:user_id, :topic_id], unique: true
        end
end
