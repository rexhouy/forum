# -*- coding: utf-8 -*-
module TopicsHelper

        def progress(activity)
                progress = activity.enrolls.size.to_f / activity.max_places.to_f * 100
                progress = 100 if progress >= 100
                progress.to_s + "%"
        end

        def enroll_count(activity)
                enroll_size = activity.enrolls.size
                txt = "#{activity.min_places} ~ #{activity.max_places}人"
                txt << " #{enroll_size}人已报名" if enroll_size > 0
                txt
        end

end
