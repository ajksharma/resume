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
      ::Resume::Base.new File.join(File.dirname(__FILE__), file), :print => options[:print]
    end
  end
end
