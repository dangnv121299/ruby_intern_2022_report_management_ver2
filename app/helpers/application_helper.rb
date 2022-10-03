module ApplicationHelper
  include Pagy::Frontend
  def full_title page_title = ""
    base_title = t ".base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      text = "<script>toastr.#{type}('#{message}', '',
            { closeButton: true, progressBar: true })</script>"
      flash_messages << text if message
    end.join("\n")
  end
end
