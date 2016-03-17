# -*- coding: utf-8 -*-
module UsersHelper


        def enroll_fee_total(topic)
                promotion = topic.enroll_promotion || 0
                topic.enroll_fee - promotion
        end

end
