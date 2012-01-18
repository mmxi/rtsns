# encoding: utf-8
module ApplicationHelper
  def rtsns_error_messages(resource)
    if resource && (not resource.errors.empty?)
      error_key = 'errors.messages.not_saved'
      errors = resource.errors.full_messages
      sentence = I18n.t(error_key, :count => errors.count)
      messages = errors.map { |msg| content_tag(:li, msg) }.join
      
      html = <<-HTML
      <div class="alert-message block-message error">
        <a class="close" href="#">×</a>
        <div id="error_explanation">
          <h2>#{sentence}</h2>
          <ul>#{messages}</ul>
        </div>
      </div>
      HTML
      
      html.html_safe
    end
  end
end
