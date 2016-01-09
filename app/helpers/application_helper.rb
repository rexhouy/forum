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


        def paginate_info(obj)
                total_pages = ((obj.total_entries - 1) / obj.per_page + 1).to_i
                %(
                    <div class="page-info">当前第#{obj.current_page}页，总计#{total_pages}页，总记录数#{obj.total_entries}</div>
                ).html_safe
        end

end
