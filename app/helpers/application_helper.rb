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
end
