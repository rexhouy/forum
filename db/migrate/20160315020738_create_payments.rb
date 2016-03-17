class CreatePayments < ActiveRecord::Migration
        def change
                create_table :payments do |t|
                        t.text :trade_info
                        t.references :enroll
                        t.timestamps
                end
        end
end
