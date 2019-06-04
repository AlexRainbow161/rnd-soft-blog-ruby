# frozen_string_literal: true

module ApplicationHelper
  def notice_to_success(n_key)
    n_key = 'success' if n_key == 'notice'
    n_key = 'danger' if n_key == 'alert'
    n_key
    end

  def mail_intervals
    intervals = []
    MailInterval.all.each do |interval|
      intervals << [interval.name, interval.id]
    end
    intervals
  end

  def subscribe_types
    _types = []
    SubscribeType.all.each do |_type|
      _types << [_type.name, _type.id]
    end
    _types
  end
  def svg_helper(file_name)
    render text: "svg/#{file_name}"
  end
end
