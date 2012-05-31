module ApplicationHelper

  # so that I don't have to type out the entire bloody title every time
  def full_title(page_title)
    base_title = "MSPS"
    if page_title.blank?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

end
