class AddTelToEnrolls < ActiveRecord::Migration
        def change
                add_column :enrolls, :tel, :string
        end
end
