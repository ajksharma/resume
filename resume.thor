#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'date'
Bundler.require

module Resume 
  class ResumeTask < Thor
    namespace :resume
    desc "build", "Generate a resume"
    method_option :print, :aliases => "-p", :desc => 'Skip generating a background image for better printing'
    def build(file)
      ::Resume::Document.print_background = false if options[:print]

      resume = File.read(File.join(File.dirname(__FILE__), file))
      pdf    = ::Resume::Document.new resume
      pdf.render_file
    end
  end
end
