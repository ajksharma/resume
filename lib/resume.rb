
require 'active_support/inflector'
require 'date'
require 'nokogiri'
require 'prawn'
require 'rtf'
require 'thor'
require 'time_difference'

require 'resume/base'
require 'resume/document'
require 'resume/document/html'
require 'resume/document/pdf'
require 'resume/document/rtf'
require 'resume/experience'

# This must be required last.
require 'resume/cli'

# Helpers for Rails.
if defined?(Rails)
  require 'resume/view_helpers'
  require 'resume/railtie'
end

module Resume

end
