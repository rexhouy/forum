class AddTopicIdToChats < ActiveRecord::Migration
        def change
                add_column :chats, :topic_id, :integer
        end
end
