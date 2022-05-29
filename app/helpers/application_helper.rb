module ApplicationHelper
  def flash_messages
    flash.map { |key, msg| (content_tag :p, sanitize(msg, { attributes: %w(target href) }),
                                        :id => key, :class => 'flash ' + key) }.join.html_safe
  end
end
