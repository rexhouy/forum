# -*- coding: utf-8 -*-
module ApplicationHelper

        def admin_login?
                session[:previous_url].present? && session[:previous_url].starts_with?("/admin")
        end

        def display_date(date)
                date.strftime("%Y-%m-%d") if date.present?
        end

        def display_date_zh(date)
                date.strftime("%Y年%m月%d日") if date.present?
        end

        def display_datetime(date)
                date.strftime("%Y-%m-%d %H:%M:%S") if date.present?
        end

        def display_datetime_zh(date)
                date.strftime("%Y年%m月%d日 %H时%M分") if date.present?
        end


        def avatar(user, options = {})
                url = user.avatar
                url = "avatar.png" unless url.present?
                image_tag(url, options).html_safe
        end

        def paginate_info(obj)
                total_pages = ((obj.total_entries - 1) / obj.per_page + 1).to_i
                %(
                    <div class="page-info">当前第#{obj.current_page}页，总计#{total_pages}页，总记录数#{obj.total_entries}</div>
                ).html_safe
        end

        def enroll_status(enroll)
                return "<span class='text-danger'>尚未支付</span>".html_safe if need_payment?(enroll)
                return "<span class='text-success'>已经报名</span>".html_safe if enroll.created?
                return "<span class='text-success'>已支付报名费</span>".html_safe if enroll.paid?
                return "<span class='text-success'><i class='glyphicon glyphicon-ok-circle'></i> 管理员已确认</span>".html_safe if enroll.confirmed?
                ""
        end

        def need_payment?(enroll)
                enroll.created? && enroll.topic.enroll_fee.present?
        end

end
