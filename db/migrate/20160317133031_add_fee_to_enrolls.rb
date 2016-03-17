class AddFeeToEnrolls < ActiveRecord::Migration
        def change
                add_column :enrolls, :fee, :decimal, precision: 8, scale: 2
        end
end
