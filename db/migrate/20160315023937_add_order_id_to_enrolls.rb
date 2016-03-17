class AddOrderIdToEnrolls < ActiveRecord::Migration
        def change
                add_column :enrolls, :order_id, :string
        end
end
