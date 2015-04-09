module ApplicationHelper
  def fix_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end
  def format_date_time(dt)
    dt.strftime("%d/%m/%Y - %H:%M")
  end
end
