json.array!(@chats) do |chat|
        json.extract! chat, :text, :name, :avatar, :created_at
        json.created_at display_datetime chat.created_at
end
