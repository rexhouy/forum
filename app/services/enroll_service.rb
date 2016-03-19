class EnrollService

        def paid(order_id, payment)
                enroll = Enroll.find_by_order_id(order_id)
                Rails.logger.error "Enroll not found #{order_id}" if enroll.nil?
                if enroll.created?
                        Enroll.transaction do
                                enroll.update(status: Enroll.statuses[:paid])
                                create_enroll_history(enroll)
                                create_payment(enroll, payment)
                        end
                        #  TODO send_notify_to_seller(order)
                else
                        Rails.logger.error "Update enroll status to paid has failed. Enroll status incorrect. enroll id [#{enroll.order_id}], status [#{enroll.status}]"
                end
        end

        private
        def create_payment(enroll, info)
                payment = Payment.new
                payment.enroll = enroll
                payment.trade_info = info
                payment.save!
        end

        def create_enroll_history(enroll, user = nil)
                history = EnrollHistory.new
                history.enroll_id = enroll.id
                history.status = enroll.status
                history.user_id = user.id if user.present?
                history.save!
        end


end
