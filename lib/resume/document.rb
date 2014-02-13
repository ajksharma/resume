#!/usr/bin/env ruby

module Resume
  module Document
    
    attr_accessor :resume
    
    # This sets a basic initialize hook that 
    # runs your initialization, then adds the resume attribute.
    def initialize (resume, *args)
      super(*args)

      self.resume = Base.new resume, :render => self
    
      # Call :after_initialize hook if one is defined.
      self.after_initialize if self.respond_to?(:after_initialize)
      
      self
    end
    

      
  end
  
end    
