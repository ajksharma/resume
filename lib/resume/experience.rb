#!/usr/bin/env ruby

require 'resume/experience/base'
require 'resume/experience/degree'
require 'resume/experience/job'
require 'resume/experience/project'
require 'resume/experience/school'

module Resume
  module Experience 

    # This is a class method that adds two methods to a class
    # A command to add an experience of that type
    # and a method to fetch all experiences of that type.
    def has_experience (*args)
      args.each do |xp|
        self.send :define_method, xp do |title, options = {}, &block|
          ( self.instance_variable_get(:"@#{xp.to_s.pluralize}") || 
            self.instance_variable_set(:"@#{xp.to_s.pluralize}", []) ) << 
            "::Resume::Experience::#{xp.to_s.camelize}".constantize.new(options.merge(:title => title), &block)
        end
      
        self.send :define_method, :"#{xp.to_s.pluralize}" do
          ( self.instance_variable_get(:"@#{xp.to_s.pluralize}") || 
            self.instance_variable_set(:"@#{xp.to_s.pluralize}", []) ).sort { |a,b| b.start_on <=> a.start_on } 
        end
      end  
    end
    
  end
end
