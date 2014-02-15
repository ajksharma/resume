# lib/resume/view_helpers.rb

# Just a helper method for rails
# returns the html render with html_safe text.
module Resume
  module ViewHelpers
    
    def resume (text)
      ::Resume::Document::Html.new(text).to_html.html_safe
    end

  end
end
