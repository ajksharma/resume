#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'date'
Bundler.require

module Resume 
  class ResumeTask < Thor
    namespace :resume
    desc "build", "Generate a resume"
    def build(file)
      ::Resume::Base.new File.join(File.dirname(__FILE__), file)
    end
  end
end
