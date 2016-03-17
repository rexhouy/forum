class Enroll < ActiveRecord::Base

        belongs_to :topic
        belongs_to :user
        has_many :enroll_histories

        enum status: [:created, :paid, :confirmed]

        before_create do
                self.status = Enroll.statuses[:created]
        end

end
