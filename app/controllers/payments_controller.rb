require "json"
class PaymentsController < ApplicationController

        def alipay_redirect
                enroll = Enroll.find(params[:id])
                @enroll_id = params[:id]
                @url = Config::PAYMENT["alipay"]["mobile_pay"]["url"].clone
                @url << "?" << AlipayService.new.pay(enroll).to_query
                render layout: false
        end

        def alipay_notify
                if ["TRADE_FINISHED", "TRADE_SUCCESS"].include?(params[:trade_status])
                        EnrollService.new.paid(params[:out_trade_no], params.to_json)
                        logger.info "Payment succeed [#{params[:out_trade_no]}]."
                end
                render plain: "success"
        end

        def alipay_front_notify
                @enroll = Enroll.find_by_order_id(params[:out_trade_no])
                @success = ["TRADE_FINISHED", "TRADE_SUCCESS"].include?(params[:trade_status])
                render "result", layout: false
        end

        private
        def valid?(valid_fields)
                SignatureService.new.check_signature(
                                                     notify_params(valid_fields),
                                                     params[:signature])
        end

        def notify_params(keys)
                valid_params = {}
                keys.each do |key|
                        valid_params[key] = params[key]
                end
                logger.debug "received notify params: #{valid_params.inspect}"
                valid_params
        end

end
