module ApplicationHelper
    def notice_to_success(n_key)
        if n_key === "notice"
          n_key = "success"
        end
        if n_key === "alert"
          n_key = "danger"
        end
        return n_key
      end
    def mail_intervals
      intervals = []
      MailInterval.all.each do |interval|
        intervals << [interval.name, interval.id]
      end
      return intervals
    end

    def subscribe_types
      _types = []
      SubscribeType.all.each do |_type|
        _types << [_type.name, _type.id]
      end
      return _types
    end
end
