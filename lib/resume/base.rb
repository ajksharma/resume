#!/usr/bin/env ruby

require 'resume/experience'

module Resume

  class Base
    extend Experience
    
    attr_accessor :document, :summary
    
    has_experience :job, :project, :sample, :school
   
    def initialize(content, opts = {})
      self.document = opts[:render]
      proc          = ::Proc.new {}
      eval(content, proc.binding, 'resume')
    end 

    # commands for the dsl
    def email (value = nil)
      @email = value || @email || ''
    end

    def hobby(value, opts = { :under => :other } )
      ( ( @hobbies ||= {} )[opts[:under].to_s.titleize] ||= [] ) << value.to_s.camelize
    end

    def hobbies
      @hobbies ||= {}
      Hash[@hobbies.except('Other').sort].merge @hobbies.slice('Other')
    end

    def name (value = nil)
      @name = value || @name || 'Please specify name'
    end

    def samples
      ( @samples ||= [] ).sort { |a,b| a.title <=> b.title }
    end

    def print(method, data = nil, opts = nil)
      # TODO: Check if Module defines method, and raise a not defined.
      # here.
      # class << Something; self; end
      raise NotImplementedError unless self.document.class.method_defined?(method)

      data = if data.nil? && self.class.method_defined?(method)
                self.send(method)
              else
                self.send(data)
              end

      args = [ data, opts ].compact

      self.document.send(method, *args)
    end

    def skill(value, opts = { :under => :other } )
      ( ( @skills ||= {} )[opts[:under].to_s.titleize] ||= [] ) << value.to_s.camelize
    end

    def skills
      @skills ||= {}
      Hash[@skills.except('Other').sort].merge(@skills.slice('Other'))
    end

    def summarize (text)
      self.summary = text
    end

    def title
      self.jobs.first.try(:title)
    end

    private

    def commands
      @commands ||= []
    end
  end
end
