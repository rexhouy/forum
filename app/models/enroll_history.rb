class EnrollHistory < ActiveRecord::Base

        belongs_to :enroll

        enum status: [:created, :paid, :confirmed]

end
