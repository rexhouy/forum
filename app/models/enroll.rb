class Enroll < ActiveRecord::Base

        belongs_to :topic
        belongs_to :user
        has_many :enroll_histories

        enum status: [:created, :paid, :confirmed]

        before_create do
                self.status = Enroll.statuses[:created]
        end

        def joined?(user_tel)
                user_tel.eql?(tel) && ((!fee.nil? && paid?) || (fee.nil? && created?))
        end

end
