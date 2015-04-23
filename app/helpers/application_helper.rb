module ApplicationHelper
  def fix_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end
  def format_date_time(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("%d/%m/%Y - %H:%M - %Z")
  end
end
