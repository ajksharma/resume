#!/usr/bin/env ruby

module Resume
  module Document
    
    attr_accessor :resume
    
    # This sets a basic initialize hook that 
    # runs your initialization, then adds the resume attribute.
    def initialize (resume, *args)
      self.resume = Base.new resume, :render => self
    
      super(*args)

      # Call :after_initialize hook if one is defined.
      self.after_initialize if self.respond_to?(:after_initialize)

      self.resume.render

      self
    end
    

      
  end
  
end    
