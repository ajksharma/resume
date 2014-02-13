#!/usr/bin/env ruby

module Resume 
  class Cli < ::Thor

    desc "build", "Generate a resume"

    method_option :print, :aliases => "-p", :desc => 'Skip generating a background image for better printing'

    def build(file)

      ::Resume::Document::Pdf.print_background = !options.has_key?(:print)

      resume = File.read(file)
      pdf    = ::Resume::Document::Pdf.new resume

      pdf.render_file
    end

  end
end
