module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "layouts.application.app_name"
    if page_title.nil?
      base_title
    else
      page_title
    end
  end
end
