module NotificationsHelper
  def posted_time(time)
    time > Date.today ? "#{time_ago_in_words(time)}" : time.strftime('%m月%d日')
  end

  def already_read(boolean)
    if boolean == true
      '既読'
    elsif boolean == false
      '未読'
    end
  end
end
