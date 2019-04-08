module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t :ruby_on_rails_tut_sample_app
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
