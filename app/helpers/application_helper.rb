module ApplicationHelper
  def page_header(text)
    render partial: 'parts/page_header', locals: {text: text }
  end
end
