module ApplicationHelper
  def year()
    current_year = Time.new.year
  end
  def flash_class(level)
    case level
        when "notice" then "alert alert-info"
        when "success" then "alert alert-success"
        when "error" then "alert alert-danger"
        when "alert" then "alert alert-danger"
        else
          level.to_s
    end
  end
end
